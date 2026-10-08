from pathlib import Path

from database import get_connection


BASE_DIR = Path(__file__).parent.parent

FILES = [
    {
        "path": BASE_DIR / "data" / "csv" / "transactions.csv",
        "stage": "@SNOWFLAKE_DE_LAB.RAW.CSV_STAGE"
    },
    {
        "path": BASE_DIR / "data" / "json" / "transactions.json",
        "stage": "@SNOWFLAKE_DE_LAB.RAW.JSON_STAGE"
    },
    {
        "path": BASE_DIR / "data" / "parquet" / "transactions.parquet",
        "stage": "@SNOWFLAKE_DE_LAB.RAW.PARQUET_STAGE"
    }
]


with get_connection() as connection:
    with connection.cursor() as cursor:

        for item in FILES:
            file_path = item["path"].as_posix()
            stage = item["stage"]

            put_sql = f"""
                PUT 'file://{file_path}'
                {stage}
                AUTO_COMPRESS = TRUE
                OVERWRITE = TRUE
            """

            print(f"\nUploading {item['path'].name}...")

            cursor.execute(put_sql)

            for row in cursor.fetchall():
                print(row)

print("\nInternal stage uploads complete.")