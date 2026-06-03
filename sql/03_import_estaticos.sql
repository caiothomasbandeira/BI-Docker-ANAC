-- 03 - Importar CSVs estatisticos (rodar via pgAdmin)
SET client_encoding TO 'LATIN1';

COPY repositorio.voos_2023 FROM '/data/dados_estatico/2023.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');
COPY repositorio.voos_2024 FROM '/data/dados_estatico/2024.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');
COPY repositorio.voos_2025 FROM '/data/dados_estatico/2025.csv' WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');