-- 11 — Carregar dimensão aeroporto

INSERT INTO dw.dim_aeroporto (
    aeroporto_sigla,
    aeroporto_nome,
    aeroporto_uf,
    aeroporto_regiao,
    aeroporto_pais,
    aeroporto_continente
)
SELECT DISTINCT ON (aeroporto_sigla)
    aeroporto_sigla,
    aeroporto_nome,
    aeroporto_uf,
    aeroporto_regiao,
    aeroporto_pais,
    aeroporto_continente
FROM (
    SELECT
        COALESCE(aeroporto_origem_sigla, 'NÃO INFORMADO') AS aeroporto_sigla,
        COALESCE(aeroporto_origem_nome, 'NÃO INFORMADO') AS aeroporto_nome,
        COALESCE(aeroporto_origem_uf, 'EXTERIOR/NÃO INFORMADO') AS aeroporto_uf,
        COALESCE(aeroporto_origem_regiao, 'EXTERIOR/NÃO INFORMADO') AS aeroporto_regiao,
        COALESCE(aeroporto_origem_pais, 'NÃO INFORMADO') AS aeroporto_pais,
        COALESCE(aeroporto_origem_continente, 'NÃO INFORMADO') AS aeroporto_continente
    FROM repositorio.voos_unificados

    UNION ALL

    SELECT
        COALESCE(aeroporto_destino_sigla, 'NÃO INFORMADO') AS aeroporto_sigla,
        COALESCE(aeroporto_destino_nome, 'NÃO INFORMADO') AS aeroporto_nome,
        COALESCE(aeroporto_destino_uf, 'EXTERIOR/NÃO INFORMADO') AS aeroporto_uf,
        COALESCE(aeroporto_destino_regiao, 'EXTERIOR/NÃO INFORMADO') AS aeroporto_regiao,
        COALESCE(aeroporto_destino_pais, 'NÃO INFORMADO') AS aeroporto_pais,
        COALESCE(aeroporto_destino_continente, 'NÃO INFORMADO') AS aeroporto_continente
    FROM repositorio.voos_unificados
) aeroportos
ORDER BY aeroporto_sigla, aeroporto_nome;