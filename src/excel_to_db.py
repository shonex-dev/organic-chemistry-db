import pandas as pd
import sqlite3

EXCEL_PATH = "data/raw/organic_questions_schema_2026-01-28.xlsx"
DB_PATH = "data/sample/sample.db"

conn = sqlite3.connect(DB_PATH)

sheets = {
    "questions": "questions",
    "answers": "answers",
}

for sheet_name, table_name in sheets.items():
    df = pd.read_excel(EXCEL_PATH, sheet_name=sheet_name)
    df.to_sql(table_name, conn, if_exists="append", index=False)

conn.close()
print("DB作成完了")
