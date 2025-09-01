
# Investment Returns Calculator - Informal Spec

## Core Functionality

- Calculate compound investment returns with optional monthly withdrawals
- Display year-by-year breakdown in table format
- Show summary statistics

## Input Parameters

- `--amount/-a`: Initial investment (supports 100K, 1.5M, 2.3B format)
- `--rate/-r`: Annual return rate (supports 6%, 7.5%, 0.06 format)
- `--duration/-d`: Time period (supports 5y, 3y6mo, 2.5y format)
- `--withdrawal/-w`: Monthly withdrawal amount (default 0, same format as amount)
- `--truncate-table`: Show table truncation (default: show all rows)
- `--verbose/-v`: Logging levels (-v info, -vv debug, -vvv extended debug)
- `--add-fee/-f`: Subtract financial firm's fees as percentage

## Output Requirements

- Display currency without cents (whole dollars only)
- Calculate with full precision internally
- Show all table rows by default (no `...` truncation)
- Year-by-year table with columns:
    - Year, Starting Value, Annual Return, Annual Withdrawal (if applicable), Ending Value, Total Return, Total Return %, Fee totals, Total Withdrawn (if applicable)

## Withdrawal Behavior

- Calculate monthly for accuracy
- Prevent negative balances
- Track total withdrawn amount
- Show months/years remaining at current rate
- Warn if balance depleted

## Technical Requirements

- Use Polars for DataFrame operations
- Absolute imports only (no `from x import y`)
- Proper logging with module logger (not root logger)
- Handle fractional years correctly
- Type annotations throughout
- Ruff-compliant code (TRY300, magic numbers as constants, etc.)

## Error Handling

- Graceful parsing failures with specific error messages
- Proper exception chaining
- Log to stderr for errors
- Exit codes for different failure modes

## Architecture Notes

- Break up large main() function
- Separate parsing, calculation, and display concerns
- Use else blocks for returns in try statements
- Constants for magic numbers (verbosity levels, etc.)

// include and interpret
{{ include "../add-google-search-links/add-links.md" . | trim }}"

// webui example scaffold
{{ include "../webui-common/webui-common.md" . | trim }}"

// golang app example scaffold
{{ include "../golang-app/golang-app.md" . | trim }}"

// python package example scaffold
{{ include "../python-package/python-package.md" . | trim }}"

// no interpreting please
{{ snippet "../add-google-search-links/add-links.md" | trim }}"
