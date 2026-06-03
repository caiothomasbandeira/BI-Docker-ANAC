-- View mensal

CREATE OR REPLACE VIEW datamart.vw_evolucao_mensal AS
SELECT
    ano,
    mes,
    ano_mes,
    data_referencia,

    SUM(passageiros_total) AS passageiros_total,
    SUM(decolagens) AS decolagens,
    SUM(carga_paga_kg) AS carga_paga_kg,
    SUM(bagagem_kg) AS bagagem_kg,
    SUM(combustivel_litros) AS combustivel_litros,
    SUM(distancia_voada_km) AS distancia_voada_km,
    SUM(horas_voadas) AS horas_voadas,

    AVG(taxa_ocupacao) AS taxa_ocupacao_media

FROM datamart.vw_voos_analitico
GROUP BY ano, mes, ano_mes, data_referencia
ORDER BY data_referencia;