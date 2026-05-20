import csv
import re
import sys

path = sys.argv[1]
delimiter = sys.argv[2] if len(sys.argv) > 2 else ";"

with open(path, "r", encoding="utf-8-sig", errors="replace", newline="") as handle:
    reader = csv.reader(handle, delimiter=delimiter, quotechar='"')
    header = next(reader, [])

def sanitize(name: str, index: int) -> str:
    value = name.strip().strip('"')
    value = value.lower()
    value = re.sub(r"[^a-z0-9]+", "_", value).strip("_")
    return value or f"col_{index}"

seen = set()
columns = []
for idx, raw in enumerate(header, start=1):
    base = sanitize(raw, idx)
    name = base
    suffix = 1
    while name in seen:
        suffix += 1
        name = f"{base}_{suffix}"
    seen.add(name)
    columns.append(f'"{name}" text')

print(", ".join(columns))
