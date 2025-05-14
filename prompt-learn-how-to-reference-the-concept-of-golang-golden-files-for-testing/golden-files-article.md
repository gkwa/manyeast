
![](https://miro.medium.com/v2/resize:fit:700/1*WYO18AWpD_k6InGcLnJLGA.jpeg)

[[go - go test golden files]]

[Testing with golden files in Go](https://medium.com/soon-london/testing-with-golden-files-in-go-7fccc71c43d3)

When writing unit tests, there comes a point when you need to check that the complex output of a function matches your expectations.

This could be binary data (like an Image), `JSON`, `HTML` etc.

Golden files are a way of ensuring your function output matches its `.golden` file.

It's a pattern used in the Go standard library, which we're going to take a look at now.

We'll start by writing a fairly contrived function that we want to test the output of, let's use `JSON` for simplicity.

```go
// main.go
package main

import (
    "encoding/json"
    "io"
)

type Person struct {
    Foo string `json:"foo"`
    Bar string `json:"bar"`
}

func ToJSON(w io.Writer) error {
    p := Person{
        Foo: "Foo",
        Bar: "Bar",
    }

    return json.NewEncoder(w).Encode(p)
}
```

Our `ToJSON` function takes an `io.Writer`, encoding and writing some `JSON` to it.

This is fairly standard stuff if you are writing `RESTful` `JSON` based `HTTP` APIs.

Now we want to test the output of our function, or more precisely, test it writes the `JSON` we expect.

We could write a test case that writes the same `JSON` structure to a `[]byte` and compare the two but that feels a bit crufty, especially if we had to do that for n number of endpoints that write `JSON`.

This is when `.golden` files come in handy as we are able to read these files on a per test case basis and use them to compare our function outputs.

Let's setup our directory structure:

```
- testdata/
  - TestToJSON.golden
- main.go
- main_test.go
```

We have created a `testdata` directory, which is the convention in `go` for storing test fixtures, golden files etc.

Within this we have created a file named `TestToJSON.golden`, the name of which matches that of our test case for clarity and automation.

As it is not necessary to write the name of the file over and over, we can just use `t.Name()`.

So, let's write our test case function:

```go
// main_test.go
package main

import (
    "bytes"
    "flag"
    "os"
    "path/filepath"
    "testing"
)

var update = flag.Bool("update", false, "update .golden files")

func TestToJSON(t *testing.T) {
    var b bytes.Buffer
    if err := ToJSON(&b); err != nil {
        t.Fatalf("ToJSON() returned unexpected error: %v", err)
    }
    
    golden := filepath.Join("testdata", t.Name()+".golden")
    if *update {
        err := os.WriteFile(golden, b.Bytes(), 0644)
        if err != nil {
            t.Fatalf("Failed to update golden file: %v", err)
        }
    }
    
    expected, err := os.ReadFile(golden)
    if err != nil {
        t.Fatalf("Failed to read golden file: %v", err)
    }
    
    if !bytes.Equal(expected, b.Bytes()) {
        t.Errorf("ToJSON() = %q, want %q", b.Bytes(), expected)
    }
}
```

I won't go into this at length but essentially we create a buffer to write the `JSON`, read our `.golden` file and compare the two `[]byte` using `bytes.Equal`.

If we were to run this test, it would fail because our `.golden` file is empty and our `b.Bytes()` has some `JSON`.

We now have two options, we can edit our `.golden` file manually and insert the `JSON` we expect or we could do something slightly more interesting and have our test function update the `.golden` file when a command line flag is passed to `Go test`.

We'll go with the first option for now and use the command line flag on further iterations of the code.

To begin, lets get the test case passing by inserting the `JSON` we expect into the `.golden` file.

```
{"foo":"Foo","bar":"Bar"}
```

Our test case now passes 💥

Next, let's add our CLI flag to optionally update the `.golden` file for us, with the updated test function below:

```go
// main_test.go with update golden file flag
package main

import (
    "bytes"
    "flag"
    "io/ioutil"
    "path/filepath"
    "testing"
)

var update = flag.Bool("update", false, "update .golden files")

func TestToJSON(t *testing.T) {
    var b bytes.Buffer

    if err := ToJSON(&b); err != nil {
        t.Fatalf("ToJSON() returned unexpected error: %v", err)
    }

    golden := filepath.Join("testdata", t.Name()+".golden")
    if *update {
        ioutil.WriteFile(golden, b.Bytes(), 0644)
    }

    expected, _ := ioutil.ReadFile(golden)

    if !bytes.Equal(expected, b.Bytes()) {
        t.Errorf("ToJSON() = %q, want %q", b.Bytes(), expected)
    }
}
```

Here we've added an `update` boolean CLI flag and, if this is `true`, we write our output `JSON` to the `.golden` file and carry on the test as normal.

Obviously, with this flag the test will always pass™️, which should only be used in situations where you are confident that the output is going to be correct.

Be sure to verify the data changes otherwise you could be testing against broken data that is in your `.golden` file.

What is helpful about this is that changes to your `.golden` file show up in your `git` diff very clearly so it is easy to code review with your colleagues.

In order to use it, you simply call `go test` as follows:

`go test -v ./... -update`

It's also a good idea to run with the `-v` flag and add some sensible logging to your test cases so you have sight of what's happening and check the output.

## Bonus Round: Table Testing

Lastly, I wanted to touch upon table testing as another technique used in the `go` standard library, in which `.golden` files work very well.

I've updated the test function to use table tests and updated the file directory structure to this:

```
- testdata
  - TestToJSON
    - ok.golden
- main.go
- main_test.go
```

Now our `.golden` file is in a subdirectory, since we will be using sub tests, as illustrated below in the updated test function:

```go
// main_test.go with table tests
package main

import (
    "bytes"
    "flag"
    "io/ioutil"
    "path/filepath"
    "testing"
)

var update = flag.Bool("update", false, "update .golden files")

func TestToJSON(t *testing.T) {
    tests := []struct {
        name string
    }{
        {
            name: "ok",
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            var b bytes.Buffer

            if err := ToJSON(&b); err != nil {
                t.Fatalf("ToJSON() returned unexpected error: %v", err)
            }

            golden := filepath.Join("testdata", t.Name()+".golden")
            if *update {
                ioutil.WriteFile(golden, b.Bytes(), 0644)
            }

            expected, _ := ioutil.ReadFile(golden)

            if !bytes.Equal(expected, b.Bytes()) {
                t.Errorf("ToJSON() = %q, want %q", b.Bytes(), expected)
            }
        })
    }
}
```

To explain, all we've done here is move the bulk of the code into a `t.Run`, which runs our test cases as defined in our `testtable`.

As a result, we now have an easy way to add more tests to our function and use `.golden` files for them all.

If you want to see this in action for yourself, take a look at the `cmd/gofmt` package, which uses the `.golden` files pattern [here](https://github.com/golang/go/tree/master/src/cmd/gofmt).

