We should have logging such that each additional `--verbose` flag will increase log level.

`-v` is an alias for `--verbose`.

When writing log messages, all log messages should be sent to stderr instead of stdout unless we're working with chrome extensions.  

When logging to stderr in chrome extensions causes chrome to complain saying the extension is failing because it sees a stream on stderr, so in the case we're working with chrome extensions logging should be sent to stdout.
