import sqlite3
import pandas as pd
from pathlib import Path

EXCEL_PATH = Path("data/raw/organic_questions_schema_v0.xlsx")
DB_PATH = Path("data/sample.db")
SCHEMA_PATH = Path("schema/schema.sql")

# 既存DBを削除
if DB_PATH.exists():
    DB_PATH.unlink()

# DB作成
conn = sqlite3.connect(DB_PATH)

# schema.sql を流す
with open(SCHEMA_PATH, "r", encoding="utf-8") as f:
    conn.executescript(f.read())

# Excel → DB
xls = pd.ExcelFile(EXCEL_PATH)
for sheet in xls.sheet_names:
    df = xls.parse(sheet)
    df.to_sql(sheet, conn, if_exists="append", index=False)

conn.close()
print("DB生成完了（Excel v0 反映）")
