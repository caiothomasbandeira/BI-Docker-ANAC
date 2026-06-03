#!/bin/sh
set -eu

DATA_DIR="/data"
MANIFEST="$DATA_DIR/manifest.tsv"

mkdir -p "$DATA_DIR/microdados" "$DATA_DIR/estatisticos"
: > "$MANIFEST"

#MICRO_URLS="
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-01.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-02.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-03.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-04.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-05.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-06.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-07.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-08.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-09.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-10.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-11.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2023/combinada2023-12.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-01.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-02.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-03.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-04.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-05.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-06.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-07.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-08.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-09.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-10.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-11.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2024/combinada2024-12.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-01.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-02.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-03.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-04.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-05.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-06.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-07.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-08.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-09.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-10.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-11.zip
#https://www.gov.br/anac/pt-br/assuntos/regulados/empresas-aereas/Instrucoes-para-a-elaboracao-e-apresentacao-das-demonstracoes-contabeis/envio-de-informacoes/combinada/2025/combinada2025-12.zip
#"

ESTAT_URLS="
https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2023
https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2024
https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/dados-estatisticos/arquivos/base-de-dados-divididas-por-ano/2025
"

record_manifest() {
  table="$1"
  filepath="$2"
  echo "${table}|${filepath}" >> "$MANIFEST"
}

curl_fetch() {
  url="$1"
  output="$2"
  curl -L --fail --retry 3 --retry-delay 2 --retry-all-errors \
    -A "Mozilla/5.0" -o "$output" "$url"
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

download_microdados() {
  url="$1"
  filename="$(basename "$url")"
  base="${filename#combinada}"
  year="${base%-??.zip}"
  month="${base#????-}"
  month="${month%.zip}"

  out_dir="$DATA_DIR/microdados/$year/$month"
  mkdir -p "$out_dir"

  cd "$out_dir"
  curl_fetch "$url" "$filename"

  if ! unzip -tq "$filename" >/dev/null 2>&1; then
    link=$(extract_links "$url" "$filename" | head -n 1)
    if [ -z "$link" ]; then
      echo "Arquivo nao parece zip e nenhum link foi encontrado: $url" >&2
      head -n 5 "$filename" >&2 || true
      exit 1
    fi
    rm -f "$filename"
    curl_fetch "$link" "$filename"
  fi

  unzip -o "$filename" -d "$out_dir"
  rm -f "$filename"

  count=0
  find "$out_dir" -maxdepth 1 -type f \( -name "*.txt" -o -name "*.TXT" \) | while read -r txt; do
    count=$((count + 1))
    table="md_${year}_${month}"
    if [ "$count" -gt 1 ]; then
      base_name="$(basename "$txt")"
      base_name="$(printf "%s" "$base_name" | tr 'A-Z' 'a-z' | sed 's/[^a-z0-9]/_/g' | sed 's/_\+/_/g' | sed 's/^_//;s/_$//')"
      base_name="${base_name%_txt}"
      table="md_${year}_${month}_${base_name}"
    fi
    record_manifest "$table" "$txt"
  done
}

download_estatisticos() {
  url="$1"
  year="$(echo "$url" | awk -F/ '{print $NF}')"
  out_dir="$DATA_DIR/estatisticos/$year"
  mkdir -p "$out_dir"
  rm -f "$out_dir"/*

  cd "$out_dir"
  index_html="$out_dir/index.html"
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
    curl_fetch "$link" "$name"
  done

  for zip in "$out_dir"/*.zip "$out_dir"/*.ZIP; do
    [ -f "$zip" ] || continue
    unzip -o "$zip" -d "$out_dir"
    rm -f "$zip"
  done

  count=0
  for csv in "$out_dir"/*.csv "$out_dir"/*.CSV "$out_dir"/*.txt "$out_dir"/*.TXT; do
    [ -f "$csv" ] || continue
    count=$((count + 1))
    table="esta_${year}"
    if [ "$count" -gt 1 ]; then
      base_name="$(basename "$csv")"
      base_name="$(printf "%s" "$base_name" | tr 'A-Z' 'a-z' | sed 's/[^a-z0-9]/_/g' | sed 's/_\+/_/g' | sed 's/^_//;s/_$//')"
      base_name="${base_name%_csv}"
      table="esta_${year}_${base_name}"
    fi
    record_manifest "$table" "$csv"
  done
}

if [ -n "${MICRO_URLS:-}" ]; then
  for url in $MICRO_URLS; do
    download_microdados "$url"
  done
fi

if [ -n "${ESTAT_URLS:-}" ]; then
  for url in $ESTAT_URLS; do
    download_estatisticos "$url"
  done
fi
