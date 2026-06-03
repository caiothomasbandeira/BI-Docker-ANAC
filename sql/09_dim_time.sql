-- 09 — Carregar dimensão tempo

INSERT INTO dw.dim_tempo (
    data_referencia,
    ano,
    mes,
    nome_mes,
    trimestre,
    semestre,
    ano_mes
)
SELECT DISTINCT
    data_referencia,
    ano,
    mes,
    CASE mes
        WHEN 1 THEN 'Janeiro'
        WHEN 2 THEN 'Fevereiro'
        WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Maio'
        WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro'
        WHEN 11 THEN 'Novembro'
        WHEN 12 THEN 'Dezembro'
    END AS nome_mes,
    CEIL(mes / 3.0)::INTEGER AS trimestre,
    CASE 
        WHEN mes <= 6 THEN 1
        ELSE 2
    END AS semestre,
    ano_mes
FROM repositorio.voos_unificados
WHERE ano IS NOT NULL
  AND mes IS NOT NULL
  AND data_referencia IS NOT NULL
ORDER BY ano, mes
ON CONFLICT (data_referencia) DO NOTHING;  -- <== OTIMIZAÇÃO: Ignora as datas que já existem!