-- 12 — Carregar dimensão natureza

INSERT INTO dw.dim_natureza (natureza)
SELECT DISTINCT
    COALESCE(natureza, 'NÃO INFORMADO') AS natureza
FROM repositorio.voos_unificados
ORDER BY natureza;