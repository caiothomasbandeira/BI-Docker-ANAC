-- View de KPIs gerais

CREATE OR REPLACE VIEW datamart.vw_kpis_gerais AS
SELECT
    COUNT(*) AS total_registros,
    SUM(passageiros_total) AS total_passageiros,
    SUM(passageiros_pagos) AS passageiros_pagos,
    SUM(passageiros_gratis) AS passageiros_gratis,
    SUM(decolagens) AS total_decolagens,
    SUM(carga_paga_kg) AS total_carga_paga_kg,
    SUM(bagagem_kg) AS total_bagagem_kg,
    SUM(combustivel_litros) AS total_combustivel_litros,
    SUM(distancia_voada_km) AS total_distancia_voada_km,
    SUM(horas_voadas) AS total_horas_voadas,
    AVG(CASE WHEN ask > 0 THEN rpk / ask END) AS taxa_ocupacao_media
FROM datamart.vw_voos_analitico;