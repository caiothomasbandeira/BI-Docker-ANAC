-- 22 — View por rota

CREATE OR REPLACE VIEW datamart.vw_ranking_rotas AS
SELECT
    rota_codigo,
    origem_sigla,
    origem_nome,
    origem_uf,
    origem_regiao,
    origem_pais,

    destino_sigla,
    destino_nome,
    destino_uf,
    destino_regiao,
    destino_pais,

    tipo_rota,

    SUM(passageiros_total) AS passageiros_total,
    SUM(decolagens) AS decolagens,
    SUM(carga_paga_kg) AS carga_paga_kg,
    SUM(distancia_voada_km) AS distancia_voada_km,
    AVG(taxa_ocupacao) AS taxa_ocupacao_media

FROM datamart.vw_voos_analitico
GROUP BY
    rota_codigo,
    origem_sigla,
    origem_nome,
    origem_uf,
    origem_regiao,
    origem_pais,
    destino_sigla,
    destino_nome,
    destino_uf,
    destino_regiao,
    destino_pais,
    tipo_rota
ORDER BY passageiros_total DESC;