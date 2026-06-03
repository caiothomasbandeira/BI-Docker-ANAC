-- 18 — Criar Data Mart para Power BI

CREATE OR REPLACE VIEW datamart.vw_voos_analitico AS
SELECT
    fv.id_fato,

    dt.data_referencia,
    dt.ano,
    dt.mes,
    dt.nome_mes,
    dt.trimestre,
    dt.semestre,
    dt.ano_mes,

    de.empresa_sigla,
    de.empresa_nome,
    de.empresa_nacionalidade,

    ao.aeroporto_sigla AS origem_sigla,
    ao.aeroporto_nome AS origem_nome,
    ao.aeroporto_uf AS origem_uf,
    ao.aeroporto_regiao AS origem_regiao,
    ao.aeroporto_pais AS origem_pais,
    ao.aeroporto_continente AS origem_continente,

    ad.aeroporto_sigla AS destino_sigla,
    ad.aeroporto_nome AS destino_nome,
    ad.aeroporto_uf AS destino_uf,
    ad.aeroporto_regiao AS destino_regiao,
    ad.aeroporto_pais AS destino_pais,
    ad.aeroporto_continente AS destino_continente,

    dn.natureza,
    dgv.grupo_voo,

    dr.rota_codigo,
    dr.tipo_rota,

    fv.passageiros_pagos,
    fv.passageiros_gratis,
    fv.passageiros_total,

    fv.carga_paga_kg,
    fv.carga_gratis_kg,
    fv.correio_kg,
    fv.bagagem_kg,

    fv.ask,
    fv.rpk,
    fv.atk,
    fv.rtk,

    fv.combustivel_litros,
    fv.distancia_voada_km,
    fv.decolagens,

    fv.carga_paga_km,
    fv.carga_gratis_km,
    fv.correio_km,

    fv.assentos,
    fv.payload,
    fv.horas_voadas,

    CASE 
        WHEN fv.ask > 0 THEN fv.rpk / fv.ask
        ELSE NULL
    END AS taxa_ocupacao,

    CASE 
        WHEN fv.decolagens > 0 THEN fv.passageiros_total / fv.decolagens
        ELSE NULL
    END AS passageiros_por_decolagem,

    CASE 
        WHEN fv.decolagens > 0 THEN fv.combustivel_litros / fv.decolagens
        ELSE NULL
    END AS combustivel_por_decolagem

FROM dw.fato_voos fv
JOIN dw.dim_tempo dt 
    ON dt.id_tempo = fv.id_tempo
JOIN dw.dim_empresa de 
    ON de.id_empresa = fv.id_empresa
JOIN dw.dim_aeroporto ao 
    ON ao.id_aeroporto = fv.id_aeroporto_origem
JOIN dw.dim_aeroporto ad 
    ON ad.id_aeroporto = fv.id_aeroporto_destino
JOIN dw.dim_natureza dn 
    ON dn.id_natureza = fv.id_natureza
JOIN dw.dim_grupo_voo dgv 
    ON dgv.id_grupo_voo = fv.id_grupo_voo
JOIN dw.dim_rota dr 
    ON dr.id_rota = fv.id_rota;