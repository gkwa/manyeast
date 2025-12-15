# Product Data Storage Spec

## Overview

Store product HTML blobs from HTTP in SQLite using Python and FastAPI.

## Input Schema

```json
{
  "html": "base64-encoded HTML string",
  "productUrl": "string",
  "parentPageUrl": "string",
  "site": "string",
  "index": "integer",
  "hash": "string (precomputed)",
  "capturedAt": "ISO 8601 timestamp"
}
```

## Configuration

Via environment variables:

- Host
- Port
- DB path

## API

- `POST /products` — receive and store product data
- `GET /health` — health check

## Client CLI

Uses argparse with subcommands:

### `run`

Start the FastAPI server

### `db`

- `db setup` — initialize the database
- `db teardown` — remove the database

### `search`

- `--since` — time window (e.g., `2m`, `1h30m`, `45s`), filters on `capturedAt`
- `--limit` — max results to return
- `--html` — filter by HTML content
- `--product-url` — filter by productUrl
- `--parent-page-url` — filter by parentPageUrl
- `--site` — filter by site
- `--hash` — filter by hash
- `--regex` — flag to interpret string filters as regex (otherwise substring)
- Output as JSON (pipeable to jq)

## Behavior

### Ingestion

- Base64 decode HTML before storing
- Hash is provided in payload (computed upstream)
- If hash exists → skip and log that it's already present
- If hash doesn't exist → insert
- Store entire payload (all fields) to accommodate future schema additions

### Error Handling

- Log errors and continue

### Logging

- Log to stdout and file

### Data Retention

- Support purging old records (mechanism TBD)







{{ include "../python-package/python-package.md" . | trim }}"
