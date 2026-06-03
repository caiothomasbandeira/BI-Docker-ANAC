-- 08 — Criar tabela fato

CREATE TABLE dw.fato_voos (
    id_fato BIGSERIAL PRIMARY KEY,

    id_tempo INTEGER NOT NULL REFERENCES dw.dim_tempo(id_tempo),
    id_empresa INTEGER NOT NULL REFERENCES dw.dim_empresa(id_empresa),
    id_aeroporto_origem INTEGER NOT NULL REFERENCES dw.dim_aeroporto(id_aeroporto),
    id_aeroporto_destino INTEGER NOT NULL REFERENCES dw.dim_aeroporto(id_aeroporto),
    id_natureza INTEGER NOT NULL REFERENCES dw.dim_natureza(id_natureza),
    id_grupo_voo INTEGER NOT NULL REFERENCES dw.dim_grupo_voo(id_grupo_voo),
    id_rota INTEGER NOT NULL REFERENCES dw.dim_rota(id_rota),

    codigo_rota TEXT,

    passageiros_pagos NUMERIC,
    passageiros_gratis NUMERIC,
    passageiros_total NUMERIC,

    carga_paga_kg NUMERIC,
    carga_gratis_kg NUMERIC,
    correio_kg NUMERIC,
    bagagem_kg NUMERIC,

    ask NUMERIC,
    rpk NUMERIC,
    atk NUMERIC,
    rtk NUMERIC,

    combustivel_litros NUMERIC,
    distancia_voada_km NUMERIC,
    decolagens NUMERIC,

    carga_paga_km NUMERIC,
    carga_gratis_km NUMERIC,
    correio_km NUMERIC,

    assentos NUMERIC,
    payload NUMERIC,
    horas_voadas NUMERIC
);