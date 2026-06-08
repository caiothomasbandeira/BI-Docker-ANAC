-- 06 — Conferir se a união funcionou (Auditoria de Qualidade de Dados)

-- 1. Resumo por Ano com Total Geral 
-- Objetivo: Ver o volume total da tabela unificada e a distribuição macro por ano.
SELECT 
    COALESCE(ano::TEXT, 'TOTAL GERAL') AS ano_referencia, 
    COUNT(*) AS quantidade_de_linhas
FROM 
    repositorio.voos_unificados
GROUP BY 
    ROLLUP(ano)
ORDER BY 
    ano NULLS LAST;


-- 2. Validação por Arquivo de Origem
-- Objetivo: Garantir que nenhuma linha se perdeu ou duplicou durante a leitura dos CSVs.
SELECT 
    arquivo_origem,
    COUNT(*) AS quantidade_registros
FROM 
    repositorio.voos_unificados
GROUP BY 
    arquivo_origem
ORDER BY 
    arquivo_origem;


-- 3. Detalhamento Mensal 
-- Objetivo: Checar se não faltam meses específicos (ex: dados quebrados no meio do ano).
SELECT 
    ano,
    mes,
    COUNT(*) AS quantidade_registros
FROM 
    repositorio.voos_unificados
GROUP BY 
    ano, mes
ORDER BY 
    ano, mes;