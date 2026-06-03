-- 06 — Conferir se a união funcionou

SELECT 
    ano,
    mes,
    COUNT(*) AS quantidade_registros
FROM repositorio.voos_unificados
GROUP BY ano, mes
ORDER BY ano, mes;

SELECT 
    arquivo_origem,
    COUNT(*) AS quantidade_registros
FROM repositorio.voos_unificados
GROUP BY arquivo_origem
ORDER BY arquivo_origem;