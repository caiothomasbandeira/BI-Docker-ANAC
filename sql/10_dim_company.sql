-- 10 — Carregar dimensão empresa

INSERT INTO dw.dim_empresa (
    empresa_sigla,
    empresa_nome,
    empresa_nacionalidade
)
SELECT DISTINCT ON (COALESCE(empresa_sigla, 'NÃO INFORMADO'))
    COALESCE(empresa_sigla, 'NÃO INFORMADO') AS empresa_sigla,
    COALESCE(empresa_nome, 'NÃO INFORMADO') AS empresa_nome,
    COALESCE(empresa_nacionalidade, 'NÃO INFORMADO') AS empresa_nacionalidade
FROM repositorio.voos_unificados
ORDER BY 
    COALESCE(empresa_sigla, 'NÃO INFORMADO'),
    empresa_nome;