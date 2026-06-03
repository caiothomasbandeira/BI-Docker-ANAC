-- 13 — Carregar dimensão grupo de voo

INSERT INTO dw.dim_grupo_voo (grupo_voo)
SELECT DISTINCT
    COALESCE(grupo_voo, 'NÃO INFORMADO') AS grupo_voo
FROM repositorio.voos_unificados
ORDER BY grupo_voo;