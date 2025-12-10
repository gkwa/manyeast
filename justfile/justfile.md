To orchestrate, create a justfile.

The justfile should have at least these rules:

- default: to list all rules using just --list
- setup: do main work
- test: (optional)
- teardown: cleanup artifacts we created

We want to keep our justfile simple to make it clear what to run.

If we need to use bash, we could put the bash within the justfile and that's ok
but if there are more than ~10 commands then its better to create new bash file
and have justfile call it.
