import pandas as pd
from pathlib import Path

for p in Path("data").glob("mock_data*.csv"):
    df = pd.read_csv(p)
    if df.columns[0].lower() == "id":
        df = df.drop(df.columns[0], axis=1)
        p_out = p.parent / f"{p.stem}_no_id.csv"
        df.to_csv(p_out, index=False)
        print(f"{p.name} ➜ {p_out.name}")
