from pathlib import Path
import csv
import json
import random

import pandas as pd
from faker import Faker


fake = Faker()

Faker.seed(42)
random.seed(42)


BASE_DIR = Path(__file__).parent.parent
DATA_DIR = BASE_DIR / "data"

CSV_DIR = DATA_DIR / "csv"
JSON_DIR = DATA_DIR / "json"
PARQUET_DIR = DATA_DIR / "parquet"

CSV_DIR.mkdir(parents=True, exist_ok=True)
JSON_DIR.mkdir(parents=True, exist_ok=True)
PARQUET_DIR.mkdir(parents=True, exist_ok=True)


ROW_COUNT = 10000


def generate_records():
    records = []

    for record_id in range(1, ROW_COUNT + 1):
        records.append({
            "record_id": record_id,
            "customer_id": random.randint(1, 2000),
            "transaction_date": fake.date_between(
                start_date="-2y",
                end_date="today"
            ).isoformat(),
            "amount": round(random.uniform(1, 1000), 2),
            "transaction_type": random.choice([
                "Purchase",
                "Deposit",
                "Withdrawal",
                "Payment"
            ])
        })

    return records


def write_csv(records):
    file_path = CSV_DIR / "transactions.csv"

    with open(file_path, "w", newline="", encoding="utf-8") as file:
        writer = csv.DictWriter(
            file,
            fieldnames=records[0].keys()
        )

        writer.writeheader()
        writer.writerows(records)


def write_json(records):
    file_path = JSON_DIR / "transactions.json"

    with open(file_path, "w", encoding="utf-8") as file:
        json.dump(records, file, indent=2)


def write_parquet(records):
    file_path = PARQUET_DIR / "transactions.parquet"

    dataframe = pd.DataFrame(records)

    dataframe.to_parquet(
        file_path,
        index=False
    )


records = generate_records()

write_csv(records)
write_json(records)
write_parquet(records)

print(f"Generated {ROW_COUNT:,} records.")
print("CSV, JSON, and Parquet files created.")