-- View por empresa

CREATE OR REPLACE VIEW datamart.vw_ranking_empresas AS
SELECT
    empresa_sigla,
    empresa_nome,
    empresa_nacionalidade,

    SUM(passageiros_total) AS passageiros_total,
    SUM(decolagens) AS decolagens,
    SUM(carga_paga_kg) AS carga_paga_kg,
    SUM(combustivel_litros) AS combustivel_litros,
    SUM(distancia_voada_km) AS distancia_voada_km,

    AVG(taxa_ocupacao) AS taxa_ocupacao_media

FROM datamart.vw_voos_analitico
GROUP BY empresa_sigla, empresa_nome, empresa_nacionalidade
ORDER BY passageiros_total DESC;