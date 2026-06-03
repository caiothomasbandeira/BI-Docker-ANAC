#!/bin/sh
set -eu

DATA_DIR="/data"
ESTAT_DIR="$DATA_DIR/dados_estatico"
TMP_DIR="/tmp/estatisticos"

mkdir -p "$ESTAT_DIR" "$TMP_DIR"

ESTAT_URLS="
https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2023
https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2024
https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2025
"

curl_fetch() {
  url="$1"
  output="$2"
  curl -L --fail --retry 3 --retry-delay 2 --retry-all-errors \
    -H "User-Agent: Mozilla/5.0" \
    -H "Referer: https://www.gov.br/" \
    -H "Accept: */*" \
    -H "Accept-Language: pt-BR,pt;q=0.9,en;q=0.8" \
    --compressed -o "$output" "$url"
}

extract_links() {
  base_url="$1"
  html_path="$2"
  python3 - "$base_url" "$html_path" <<'PY'
import re
import sys
import urllib.parse

base, path = sys.argv[1], sys.argv[2]
text = open(path, "r", encoding="utf-8", errors="ignore").read()
links = re.findall(r'href=["\']([^"\']+)["\']', text, flags=re.I)
seen = set()
for link in links:
    if not link:
        continue
    lowered = link.lower()
    if not (lowered.endswith(".csv") or lowered.endswith(".zip") or lowered.endswith(".txt")):
        continue
    resolved = urllib.parse.urljoin(base, link)
    if resolved in seen:
        continue
    seen.add(resolved)
    print(resolved)
PY
}

download_estatisticos() {
  url="$1"
  year="$(echo "$url" | awk -F/ '{print $NF}')"
  year_tmp="$TMP_DIR/$year"

  rm -rf "$year_tmp"
  mkdir -p "$year_tmp"

  index_html="$year_tmp/index.html"
  curl_fetch "$url" "$index_html"

  links=$(extract_links "$url" "$index_html")
  if [ -z "$links" ]; then
    echo "Nenhum arquivo encontrado na pagina: $url" >&2
    head -n 5 "$index_html" >&2 || true
    exit 1
  fi

  echo "$links" | while read -r link; do
    [ -n "$link" ] || continue
    name="$(basename "$link")"
    curl_fetch "$link" "$year_tmp/$name"
  done

  for zip in "$year_tmp"/*.zip "$year_tmp"/*.ZIP; do
    [ -f "$zip" ] || continue
    unzip -o "$zip" -d "$year_tmp"
    rm -f "$zip"
  done

  count=0
  for data in "$year_tmp"/*.csv "$year_tmp"/*.CSV "$year_tmp"/*.txt "$year_tmp"/*.TXT; do
    [ -f "$data" ] || continue
    count=$((count + 1))
    if [ "$count" -eq 1 ]; then
      cp "$data" "$ESTAT_DIR/$year.csv"
    else
      base_name="$(basename "$data")"
      cp "$data" "$ESTAT_DIR/${year}_$base_name"
    fi
  done

  if [ "$count" -eq 0 ]; then
    echo "Nenhum arquivo CSV/TXT encontrado para $year" >&2
    exit 1
  fi
}

for url in $ESTAT_URLS; do
  download_estatisticos "$url"
done
