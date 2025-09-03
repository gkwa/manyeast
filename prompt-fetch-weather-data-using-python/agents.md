# AGENTS.md

## Project Overview
Python CLI tool to fetch historical weather data using OpenWeather History API for specified locations and date ranges.

## Setup Commands
- Get OpenWeather API key from https://openweathermap.org/api
- Requires Professional or Expert subscription for historical data access

## CLI Arguments Specification

### Required Arguments
- `--api-key` - OpenWeather API key (required)
- `--days` - Number of days back to fetch (default: 7, max: 7 per API call limit)

### Location Arguments (one required)
- `--zip-code` - US ZIP code (default: 98122)
- `--lat` - Latitude coordinate
- `--lon` - Longitude coordinate  
- `--city` - City name with optional state/country (format: "City,State,Country")

### Optional Arguments
- `--units` - Temperature/speed units (choices: standard, metric, imperial; default: metric)
- `--output-format` - Response format (choices: json, csv; default: json)
- `--output-file` - Save to file path (optional)
- `--start-date` - Override with specific start date (format: YYYY-MM-DD)
- `--end-date` - Override with specific end date (format: YYYY-MM-DD)
- `--hour-limit` - Limit number of hours returned (alternative to end date)

### Behavior Options
- `--verbose` - Enable detailed logging
- `--dry-run` - Show API URL without making the call

## API Specifications
- **Endpoint**: `https://history.openweathermap.org/data/2.5/history/city`
- **Method**: GET
- **Required Parameters**: lat, lon, type=hour, start/end timestamps, appid
- **Rate Limits**: Professional/Expert subscription required
- **Data Limit**: Maximum 1 week per API call
- **Timestamp Format**: Unix timestamps in UTC

## Code Style
- Use argparse for CLI argument parsing
- Handle API errors gracefully with proper HTTP status code checking
- Validate date ranges and coordinate formats
- Convert ZIP codes to coordinates using geocoding
- Support both JSON and CSV output formats
- Include proper logging with --verbose option

## Testing Instructions
- Test with valid API key and subscription
- Verify coordinate conversion for ZIP codes
- Test date range validation (max 7 days)
- Confirm output format options work correctly
- Test error handling for invalid API keys or exceeded quotas

## Security Considerations
- Never log or output API keys
- Validate all user inputs before API calls
- Handle API rate limiting appropriately
- Use secure HTTP requests (HTTPS only)