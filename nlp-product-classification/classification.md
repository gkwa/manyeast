I've included our data in <product_data/> xml element here.

<product_data>
{{ .ProductData | trim }}
</product_data>

In a single code block, create json array of 1s and 0s according to whether each item is {{ .ProductCategory }} or not.  Don't create a new artifcate for this array; inline is fine.

The result should have this shape:

```json
[0,1,0,1,1,1,1,0]
```

The resulting array should only contain either 0s or 1s.  So for example if the first item in our array is {{ .ProductCategory }}, then we'd put 1 in a new array at that index

Before you analize each item, make sure to count the number of products in the array.

Show metadata as markdown table including
- positive
- negative
- dont know
- total count

When you've completed the alalysis, make sure the counts you've summarized match the counts that you received originally.
