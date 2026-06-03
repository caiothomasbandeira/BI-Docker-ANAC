-- 05 — Unir 2023, 2024 e 2025 em uma base única tratada

CREATE TABLE repositorio.voos_unificados AS

SELECT
    NULLIF(BTRIM(empresa_sigla), '') AS empresa_sigla,
    NULLIF(BTRIM(empresa_nome), '') AS empresa_nome,
    NULLIF(BTRIM(empresa_nacionalidade), '') AS empresa_nacionalidade,

    repositorio.to_integer_br(ano) AS ano,
    repositorio.to_integer_br(mes) AS mes,
    MAKE_DATE(
        repositorio.to_integer_br(ano),
        repositorio.to_integer_br(mes),
        1
    ) AS data_referencia,
    TO_CHAR(
        MAKE_DATE(
            repositorio.to_integer_br(ano),
            repositorio.to_integer_br(mes),
            1
        ),
        'YYYY-MM'
    ) AS ano_mes,

    NULLIF(BTRIM(aeroporto_origem_sigla), '') AS aeroporto_origem_sigla,
    NULLIF(BTRIM(aeroporto_origem_nome), '') AS aeroporto_origem_nome,
    NULLIF(BTRIM(aeroporto_origem_uf), '') AS aeroporto_origem_uf,
    NULLIF(BTRIM(aeroporto_origem_regiao), '') AS aeroporto_origem_regiao,
    NULLIF(BTRIM(aeroporto_origem_pais), '') AS aeroporto_origem_pais,
    NULLIF(BTRIM(aeroporto_origem_continente), '') AS aeroporto_origem_continente,

    NULLIF(BTRIM(aeroporto_destino_sigla), '') AS aeroporto_destino_sigla,
    NULLIF(BTRIM(aeroporto_destino_nome), '') AS aeroporto_destino_nome,
    NULLIF(BTRIM(aeroporto_destino_uf), '') AS aeroporto_destino_uf,
    NULLIF(BTRIM(aeroporto_destino_regiao), '') AS aeroporto_destino_regiao,
    NULLIF(BTRIM(aeroporto_destino_pais), '') AS aeroporto_destino_pais,
    NULLIF(BTRIM(aeroporto_destino_continente), '') AS aeroporto_destino_continente,

    NULLIF(BTRIM(natureza), '') AS natureza,
    NULLIF(BTRIM(grupo_voo), '') AS grupo_voo,

    repositorio.to_numeric_br(passageiros_pagos) AS passageiros_pagos,
    repositorio.to_numeric_br(passageiros_gratis) AS passageiros_gratis,
    repositorio.to_numeric_br(carga_paga_kg) AS carga_paga_kg,
    repositorio.to_numeric_br(carga_gratis_kg) AS carga_gratis_kg,
    repositorio.to_numeric_br(correio_kg) AS correio_kg,
    repositorio.to_numeric_br(ask) AS ask,
    repositorio.to_numeric_br(rpk) AS rpk,
    repositorio.to_numeric_br(atk) AS atk,
    repositorio.to_numeric_br(rtk) AS rtk,
    repositorio.to_numeric_br(combustivel_litros) AS combustivel_litros,
    repositorio.to_numeric_br(distancia_voada_km) AS distancia_voada_km,
    repositorio.to_numeric_br(decolagens) AS decolagens,
    repositorio.to_numeric_br(carga_paga_km) AS carga_paga_km,
    repositorio.to_numeric_br(carga_gratis_km) AS carga_gratis_km,
    repositorio.to_numeric_br(correio_km) AS correio_km,
    repositorio.to_numeric_br(assentos) AS assentos,
    repositorio.to_numeric_br(payload) AS payload,
    repositorio.to_numeric_br(horas_voadas) AS horas_voadas,
    repositorio.to_numeric_br(bagagem_kg) AS bagagem_kg,

    '2023.csv' AS arquivo_origem

FROM repositorio.voos_2023

UNION ALL

SELECT
    NULLIF(BTRIM(empresa_sigla), ''),
    NULLIF(BTRIM(empresa_nome), ''),
    NULLIF(BTRIM(empresa_nacionalidade), ''),

    repositorio.to_integer_br(ano),
    repositorio.to_integer_br(mes),
    MAKE_DATE(repositorio.to_integer_br(ano), repositorio.to_integer_br(mes), 1),
    TO_CHAR(MAKE_DATE(repositorio.to_integer_br(ano), repositorio.to_integer_br(mes), 1), 'YYYY-MM'),

    NULLIF(BTRIM(aeroporto_origem_sigla), ''),
    NULLIF(BTRIM(aeroporto_origem_nome), ''),
    NULLIF(BTRIM(aeroporto_origem_uf), ''),
    NULLIF(BTRIM(aeroporto_origem_regiao), ''),
    NULLIF(BTRIM(aeroporto_origem_pais), ''),
    NULLIF(BTRIM(aeroporto_origem_continente), ''),

    NULLIF(BTRIM(aeroporto_destino_sigla), ''),
    NULLIF(BTRIM(aeroporto_destino_nome), ''),
    NULLIF(BTRIM(aeroporto_destino_uf), ''),
    NULLIF(BTRIM(aeroporto_destino_regiao), ''),
    NULLIF(BTRIM(aeroporto_destino_pais), ''),
    NULLIF(BTRIM(aeroporto_destino_continente), ''),

    NULLIF(BTRIM(natureza), ''),
    NULLIF(BTRIM(grupo_voo), ''),

    repositorio.to_numeric_br(passageiros_pagos),
    repositorio.to_numeric_br(passageiros_gratis),
    repositorio.to_numeric_br(carga_paga_kg),
    repositorio.to_numeric_br(carga_gratis_kg),
    repositorio.to_numeric_br(correio_kg),
    repositorio.to_numeric_br(ask),
    repositorio.to_numeric_br(rpk),
    repositorio.to_numeric_br(atk),
    repositorio.to_numeric_br(rtk),
    repositorio.to_numeric_br(combustivel_litros),
    repositorio.to_numeric_br(distancia_voada_km),
    repositorio.to_numeric_br(decolagens),
    repositorio.to_numeric_br(carga_paga_km),
    repositorio.to_numeric_br(carga_gratis_km),
    repositorio.to_numeric_br(correio_km),
    repositorio.to_numeric_br(assentos),
    repositorio.to_numeric_br(payload),
    repositorio.to_numeric_br(horas_voadas),
    repositorio.to_numeric_br(bagagem_kg),

    '2024.csv'

FROM repositorio.voos_2024

UNION ALL

SELECT
    NULLIF(BTRIM(empresa_sigla), ''),
    NULLIF(BTRIM(empresa_nome), ''),
    NULLIF(BTRIM(empresa_nacionalidade), ''),

    repositorio.to_integer_br(ano),
    repositorio.to_integer_br(mes),
    MAKE_DATE(repositorio.to_integer_br(ano), repositorio.to_integer_br(mes), 1),
    TO_CHAR(MAKE_DATE(repositorio.to_integer_br(ano), repositorio.to_integer_br(mes), 1), 'YYYY-MM'),

    NULLIF(BTRIM(aeroporto_origem_sigla), ''),
    NULLIF(BTRIM(aeroporto_origem_nome), ''),
    NULLIF(BTRIM(aeroporto_origem_uf), ''),
    NULLIF(BTRIM(aeroporto_origem_regiao), ''),
    NULLIF(BTRIM(aeroporto_origem_pais), ''),
    NULLIF(BTRIM(aeroporto_origem_continente), ''),

    NULLIF(BTRIM(aeroporto_destino_sigla), ''),
    NULLIF(BTRIM(aeroporto_destino_nome), ''),
    NULLIF(BTRIM(aeroporto_destino_uf), ''),
    NULLIF(BTRIM(aeroporto_destino_regiao), ''),
    NULLIF(BTRIM(aeroporto_destino_pais), ''),
    NULLIF(BTRIM(aeroporto_destino_continente), ''),

    NULLIF(BTRIM(natureza), ''),
    NULLIF(BTRIM(grupo_voo), ''),

    repositorio.to_numeric_br(passageiros_pagos),
    repositorio.to_numeric_br(passageiros_gratis),
    repositorio.to_numeric_br(carga_paga_kg),
    repositorio.to_numeric_br(carga_gratis_kg),
    repositorio.to_numeric_br(correio_kg),
    repositorio.to_numeric_br(ask),
    repositorio.to_numeric_br(rpk),
    repositorio.to_numeric_br(atk),
    repositorio.to_numeric_br(rtk),
    repositorio.to_numeric_br(combustivel_litros),
    repositorio.to_numeric_br(distancia_voada_km),
    repositorio.to_numeric_br(decolagens),
    repositorio.to_numeric_br(carga_paga_km),
    repositorio.to_numeric_br(carga_gratis_km),
    repositorio.to_numeric_br(correio_km),
    repositorio.to_numeric_br(assentos),
    repositorio.to_numeric_br(payload),
    repositorio.to_numeric_br(horas_voadas),
    repositorio.to_numeric_br(bagagem_kg),

    '2025.csv'

FROM repositorio.voos_2025;