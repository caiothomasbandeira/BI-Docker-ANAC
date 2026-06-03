-- 15 — Carregar tabela fato

INSERT INTO dw.fato_voos (
    id_tempo,
    id_empresa,
    id_aeroporto_origem,
    id_aeroporto_destino,
    id_natureza,
    id_grupo_voo,
    id_rota,

    codigo_rota,

    passageiros_pagos,
    passageiros_gratis,
    passageiros_total,

    carga_paga_kg,
    carga_gratis_kg,
    correio_kg,
    bagagem_kg,

    ask,
    rpk,
    atk,
    rtk,

    combustivel_litros,
    distancia_voada_km,
    decolagens,

    carga_paga_km,
    carga_gratis_km,
    correio_km,

    assentos,
    payload,
    horas_voadas
)
SELECT
    dt.id_tempo,
    de.id_empresa,
    dao.id_aeroporto AS id_aeroporto_origem,
    dad.id_aeroporto AS id_aeroporto_destino,
    dn.id_natureza,
    dgv.id_grupo_voo,
    dr.id_rota,

    COALESCE(v.aeroporto_origem_sigla, 'NÃO INFORMADO')
    || ' → ' ||
    COALESCE(v.aeroporto_destino_sigla, 'NÃO INFORMADO') AS codigo_rota,

    v.passageiros_pagos,
    v.passageiros_gratis,
    COALESCE(v.passageiros_pagos, 0) + COALESCE(v.passageiros_gratis, 0) AS passageiros_total,

    v.carga_paga_kg,
    v.carga_gratis_kg,
    v.correio_kg,
    v.bagagem_kg,

    v.ask,
    v.rpk,
    v.atk,
    v.rtk,

    v.combustivel_litros,
    v.distancia_voada_km,
    v.decolagens,

    v.carga_paga_km,
    v.carga_gratis_km,
    v.correio_km,

    v.assentos,
    v.payload,
    v.horas_voadas

FROM repositorio.voos_unificados v

JOIN dw.dim_tempo dt
    ON dt.data_referencia = v.data_referencia

JOIN dw.dim_empresa de
    ON de.empresa_sigla = COALESCE(v.empresa_sigla, 'NÃO INFORMADO')

JOIN dw.dim_aeroporto dao
    ON dao.aeroporto_sigla = COALESCE(v.aeroporto_origem_sigla, 'NÃO INFORMADO')

JOIN dw.dim_aeroporto dad
    ON dad.aeroporto_sigla = COALESCE(v.aeroporto_destino_sigla, 'NÃO INFORMADO')

JOIN dw.dim_natureza dn
    ON dn.natureza = COALESCE(v.natureza, 'NÃO INFORMADO')

JOIN dw.dim_grupo_voo dgv
    ON dgv.grupo_voo = COALESCE(v.grupo_voo, 'NÃO INFORMADO')

JOIN dw.dim_rota dr
    ON dr.rota_codigo =
        COALESCE(v.aeroporto_origem_sigla, 'NÃO INFORMADO')
        || ' → ' ||
        COALESCE(v.aeroporto_destino_sigla, 'NÃO INFORMADO');