-- 07 — Criar dimensões do Data Warehouse

CREATE TABLE dw.dim_tempo (
    id_tempo SERIAL PRIMARY KEY,
    data_referencia DATE NOT NULL UNIQUE,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    nome_mes TEXT NOT NULL,
    trimestre INTEGER NOT NULL,
    semestre INTEGER NOT NULL,
    ano_mes TEXT NOT NULL
);

CREATE TABLE dw.dim_empresa (
    id_empresa SERIAL PRIMARY KEY,
    empresa_sigla TEXT NOT NULL,
    empresa_nome TEXT,
    empresa_nacionalidade TEXT,
    CONSTRAINT uk_dim_empresa UNIQUE (empresa_sigla)
);

CREATE TABLE dw.dim_aeroporto (
    id_aeroporto SERIAL PRIMARY KEY,
    aeroporto_sigla TEXT NOT NULL,
    aeroporto_nome TEXT,
    aeroporto_uf TEXT,
    aeroporto_regiao TEXT,
    aeroporto_pais TEXT,
    aeroporto_continente TEXT,
    CONSTRAINT uk_dim_aeroporto UNIQUE (aeroporto_sigla)
);

CREATE TABLE dw.dim_natureza (
    id_natureza SERIAL PRIMARY KEY,
    natureza TEXT NOT NULL UNIQUE
);

CREATE TABLE dw.dim_grupo_voo (
    id_grupo_voo SERIAL PRIMARY KEY,
    grupo_voo TEXT NOT NULL UNIQUE
);

CREATE TABLE dw.dim_rota (
    id_rota SERIAL PRIMARY KEY,
    aeroporto_origem_sigla TEXT NOT NULL,
    aeroporto_destino_sigla TEXT NOT NULL,
    rota_codigo TEXT NOT NULL,
    origem_pais TEXT,
    destino_pais TEXT,
    tipo_rota TEXT,
    CONSTRAINT uk_dim_rota UNIQUE (rota_codigo)
);