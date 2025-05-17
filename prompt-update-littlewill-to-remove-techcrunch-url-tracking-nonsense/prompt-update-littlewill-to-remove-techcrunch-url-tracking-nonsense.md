Based off the urlclean_thread xml element below, please update the littlewill code in littlewill_code xml element below.

The urls we're cleaning in this case are not generic but rather specific to techchrunch.

<urlclean_thread>
{{ include "thread.md" . | trim }}"
</urlclean_thread>

{{include "../txtar/txtar.md" . | trim}}

```
<littlewill_code>
{{ snippet "littlewill_subset.txtar" | trim }}"
</littlewill_code>
```
