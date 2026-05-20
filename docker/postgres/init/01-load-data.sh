#!/bin/sh
set -eu

psql_cmd="psql -v ON_ERROR_STOP=1 --username $POSTGRES_USER --dbname $POSTGRES_DB"

$psql_cmd -c "CREATE SCHEMA IF NOT EXISTS repositorio;"
$psql_cmd -c "CREATE SCHEMA IF NOT EXISTS dw;"
$psql_cmd -c "CREATE SCHEMA IF NOT EXISTS datamart;"
$psql_cmd -c "DROP SCHEMA IF EXISTS repo CASCADE;"

manifest="/tmp/manifest.tsv"
build_manifest() {
  data_root="/data"
  : > "$manifest"

  if [ -d "$data_root/microdados" ]; then
    find "$data_root/microdados" -type f \( -name "*.txt" -o -name "*.TXT" \) | while read -r file; do
      base="$(basename "$file")"
      year="$(printf "%s" "$base" | sed -n 's/.*\([0-9][0-9][0-9][0-9]\).*/\1/p')"
      month="$(printf "%s" "$base" | sed -n 's/.*-\([0-9][0-9]\)\..*/\1/p')"
      if [ -n "$year" ] && [ -n "$month" ]; then
        table="md_${year}_${month}"
        echo "${table}|${file}" >> "$manifest"
      fi
    done
  fi

  if [ -d "$data_root/dados_estatico" ]; then
    find "$data_root/dados_estatico" -type f \( -name "*.csv" -o -name "*.CSV" -o -name "*.txt" -o -name "*.TXT" \) | while read -r file; do
      base="$(basename "$file")"
      year="$(printf "%s" "$base" | sed -n 's/\([0-9][0-9][0-9][0-9]\).*/\1/p')"
      if [ -n "$year" ]; then
        table="esta_${year}"
      else
        base_name="$(printf "%s" "$base" | tr 'A-Z' 'a-z' | sed 's/[^a-z0-9]/_/g' | sed 's/_\+/_/g' | sed 's/^_//;s/_$//')"
        base_name="${base_name%_csv}"
        base_name="${base_name%_txt}"
        table="esta_${base_name}"
      fi
      echo "${table}|${file}" >> "$manifest"
    done
  fi
}

build_manifest

if [ ! -s "$manifest" ]; then
  echo "Nenhum arquivo encontrado em /data para carga." >&2
  exit 1
fi

while IFS='|' read -r table filepath; do
  [ -n "$table" ] || continue
  [ -f "$filepath" ] || continue

  cols=$(python3 /docker-entrypoint-initdb.d/derive_columns.py "$filepath" ";")
  escaped_path=$(printf "%s" "$filepath" | sed "s/'/''/g")

  $psql_cmd -c "CREATE TABLE IF NOT EXISTS repositorio.\"$table\" ($cols);"
  $psql_cmd -c "\\copy repositorio.\"$table\" FROM '$escaped_path' WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '\"');"
  echo "Carregado: repositorio.$table"
done < "$manifest"
