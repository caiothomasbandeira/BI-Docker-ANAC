-- 16 — Criar índices para melhorar consultas

CREATE INDEX idx_fato_voos_tempo ON dw.fato_voos(id_tempo);
CREATE INDEX idx_fato_voos_empresa ON dw.fato_voos(id_empresa);
CREATE INDEX idx_fato_voos_origem ON dw.fato_voos(id_aeroporto_origem);
CREATE INDEX idx_fato_voos_destino ON dw.fato_voos(id_aeroporto_destino);
CREATE INDEX idx_fato_voos_natureza ON dw.fato_voos(id_natureza);
CREATE INDEX idx_fato_voos_grupo_voo ON dw.fato_voos(id_grupo_voo);
CREATE INDEX idx_fato_voos_rota ON dw.fato_voos(id_rota);