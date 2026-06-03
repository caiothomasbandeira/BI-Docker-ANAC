-- 17 — Conferir DW

SELECT COUNT(*) FROM dw.dim_tempo;
SELECT COUNT(*) FROM dw.dim_empresa;
SELECT COUNT(*) FROM dw.dim_aeroporto;
SELECT COUNT(*) FROM dw.dim_natureza;
SELECT COUNT(*) FROM dw.dim_grupo_voo;
SELECT COUNT(*) FROM dw.dim_rota;
SELECT COUNT(*) FROM dw.fato_voos;
SELECT
    dt.ano,
    COUNT(*) AS registros,
    SUM(fv.passageiros_total) AS passageiros_total,
    SUM(fv.decolagens) AS decolagens
FROM dw.fato_voos fv
JOIN dw.dim_tempo dt ON dt.id_tempo = fv.id_tempo
GROUP BY dt.ano
ORDER BY dt.ano;