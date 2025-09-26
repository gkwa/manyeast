Our goal today is to create python project to match file paths to json records.

Our project name is {{ .ProjectName }}.

Here is the context:

Sourdough starter goes through phases in order of

- feeding
- becoming active
- peaking
- becomeing inactive

We have tracked that in json with fields having this shape:

```
| Stage     | Description                         | JSON Field        |
|-----------|-------------------------------------|-------------------|
| Feeding   | When the starter is fed             | `feed_time`       |
| Active    | When it begins bubbling/fermenting  | `active_time`     |
| Peak      | When activity is at its highest     | `peak_time`       |
| Inactive  | When activity slows after peaking   | `active_end_time` |
```

Here you can see

- the json file
- the timestamp formats of files as well as fields in json
- the path to the json file
- the directories involved


So our goal then is to loop over our json records finding each of the time
fields, creating the expected time ranges according to our sourdough lifecycle

| Stage Transition   | From Field    | To Field          | Time Range Meaning                              |
| ------------------ | ------------- | ----------------- | ----------------------------------------------- |
| Feeding → Active   | `feed_time`   | `active_time`     | Time until starter begins bubbling/fermenting   |
| Active → Peak      | `active_time` | `peak_time`       | Time it takes to reach maximum activity         |
| Peak → Inactive    | `peak_time`   | `active_end_time` | Time starter remains strong before slowing down |
| Feeding → Inactive | `feed_time`   | `active_end_time` | Total active lifecycle duration after feeding   |

We should name each of the transition states and for each transition we will
gather the list of file paths to images that fit within the time range for that
state.

For each record in our manifest will weill add that state transition as json record.


```
<command_log_showing_context>
{{ include "log.txt" . | trim }}"
</command_log_showing_context>
```

// python package example scaffold
{{ include "../python-package/python-package.md" . | trim }}"
