-- 14 — Carregar dimensão rota

INSERT INTO dw.dim_rota (
    aeroporto_origem_sigla,
    aeroporto_destino_sigla,
    rota_codigo,
    origem_pais,
    destino_pais,
    tipo_rota
)
SELECT DISTINCT
    COALESCE(aeroporto_origem_sigla, 'NÃO INFORMADO') AS aeroporto_origem_sigla,
    COALESCE(aeroporto_destino_sigla, 'NÃO INFORMADO') AS aeroporto_destino_sigla,

    COALESCE(aeroporto_origem_sigla, 'NÃO INFORMADO')
    || ' → ' ||
    COALESCE(aeroporto_destino_sigla, 'NÃO INFORMADO') AS rota_codigo,

    COALESCE(aeroporto_origem_pais, 'NÃO INFORMADO') AS origem_pais,
    COALESCE(aeroporto_destino_pais, 'NÃO INFORMADO') AS destino_pais,

    CASE
        WHEN aeroporto_origem_pais = 'BRASIL'
         AND aeroporto_destino_pais = 'BRASIL'
            THEN 'DOMÉSTICA'
        WHEN aeroporto_origem_pais IS NULL
          OR aeroporto_destino_pais IS NULL
            THEN 'NÃO INFORMADO'
        ELSE 'INTERNACIONAL'
    END AS tipo_rota

FROM repositorio.voos_unificados;