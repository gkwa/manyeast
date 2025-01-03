Motivation:

create a dagger module and test it locally

requires creating this heirarachy:

mod
mod/mod client

so module client is a subdir of the module we're creating

```bash
cd /tmp && boilerplate --output-folder=. --template-url github.com/gkwa/manyeast/bluewhispers --var ModuleConsumer=myapp --var Module=mymod && bash -x setup && just test
```

```log
just test
...
dagger call container-echo --string-arg hello
...
✔ .containerEcho(stringArg: "hello"): String! 1.9s

hello from mod mymod


Setup tracing at https://dagger.cloud/traces/setup. To hide: export STOPIT=1
```
