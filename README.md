# Snowflake Data Engineering

A hands-on Snowflake data engineering project focused on ingestion, staged file loading, incremental processing, monitoring, and Snowflake-specific pipeline patterns.

## What This Project Covers

- Snowflake environment setup
- File formats for CSV, JSON, and Parquet
- Internal stages
- `PUT` and `COPY INTO`
- Load history
- Snowpipe concepts
- Streams and tasks
- Resource monitors
- Query history and profile analysis
- Python-based Snowflake connectivity
- Synthetic test-data generation

## Project Structure

    Snowflake-Data-Engineering/
    │
    ├── data/
    │   ├── csv/
    │   │   └── transactions.csv
    │   ├── json/
    │   │   └── transactions.json
    │   └── parquet/
    │       └── transactions.parquet
    │
    ├── sql/
    │   ├── 01_setup.sql
    │   ├── 02_file_formats.sql
    │   ├── 03_internal_stage.sql
    │   ├── 04_copy_into.sql
    │   ├── 05_load_history.sql
    │   ├── 06_snowpipe.sql
    │   ├── 07_streams_tasks.sql
    │   ├── 08_resource_monitor.sql
    │   └── 09_query_profile.sql
    │
    ├── src/
    │   ├── database.py
    │   ├── database_test.py
    │   ├── generate_files.py
    │   └── load_internal_stage.py
    │
    ├── .env
    ├── .env.example
    ├── .gitignore
    ├── README.md
    └── requirements.txt

## Data Generation

`generate_files.py` creates the same synthetic transaction dataset in three formats:

    CSV
    JSON
    Parquet

This makes it possible to compare how Snowflake handles different ingestion formats.

## File Formats

Snowflake file formats are defined for:

- CSV
- JSON
- Parquet

The JSON file format uses `STRIP_OUTER_ARRAY = TRUE` so each JSON object is loaded as its own row.

## Internal Stage Loading

Local files are uploaded into Snowflake internal stages using Python and `PUT`.

Flow:

    Local File
    → Internal Stage
    → COPY INTO
    → Snowflake Table

`load_internal_stage.py` handles the upload step.

## COPY INTO

`04_copy_into.sql` loads staged files into Snowflake tables.

The project demonstrates:

- structured CSV loading
- JSON loading into `VARIANT`
- Parquet field extraction into typed columns

## Load History

`05_load_history.sql` uses Snowflake load history to inspect:

- loaded files
- rows parsed
- rows loaded
- load status
- errors
- load timestamps

This helps verify ingestion and troubleshoot file-loading problems.

## Snowpipe

`06_snowpipe.sql` demonstrates the Snowflake pipe concept.

A pipe stores a `COPY INTO` definition that can be used for incremental file ingestion.

The full external-stage and cloud-event auto-ingest pattern is intentionally deferred to the cloud section of the broader learning roadmap.

## Streams and Tasks

`07_streams_tasks.sql` demonstrates incremental processing.

Flow:

    Raw Table
    → Stream
    → Task
    → Analytics Table

The stream exposes unconsumed table changes, while the task performs DML against the stream and advances the stream offset after successful processing.

## Resource Monitoring

`08_resource_monitor.sql` demonstrates Snowflake credit monitoring and warehouse cost controls.

Thresholds can be used to:

- notify
- suspend a warehouse
- protect against unexpected credit usage

## Query Profile

`09_query_profile.sql` demonstrates how to inspect recent query execution metadata.

Useful fields include:

- elapsed time
- bytes scanned
- rows produced
- warehouse used
- execution status

This complements `EXPLAIN` by showing what actually happened during query execution.

## Technologies

- Snowflake
- Python
- Snowflake Python Connector
- Faker
- pandas
- PyArrow
- SQL
- RSA key-pair authentication
- Git

## Environment Variables

Connection settings are stored in `.env`.

Example:

    SNOWFLAKE_ACCOUNT=
    SNOWFLAKE_USER=
    SNOWFLAKE_PRIVATE_KEY_FILE=
    SNOWFLAKE_WAREHOUSE=
    SNOWFLAKE_DATABASE=
    SNOWFLAKE_SCHEMA=
    SNOWFLAKE_ROLE=

The RSA private key is stored outside the repository.

## Running the Project

Install dependencies:

    pip install -r requirements.txt

Generate local test data:

    python src\generate_files.py

Upload files to Snowflake internal stages:

    python src\load_internal_stage.py

The SQL files can then be run in sequence to create file formats, load data, inspect load history, process streams, and review Snowflake monitoring features.

## Key Takeaway

This project demonstrates a practical Snowflake ingestion and processing workflow using multiple file formats, staged loading, incremental processing, cost controls, and query monitoring.

External stages and event-driven Snowpipe ingestion will be added later as part of the cloud-storage section.