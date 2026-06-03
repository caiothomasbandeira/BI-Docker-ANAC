-- 02 — Criar tabelas brutas para receber os CSVs

CREATE TABLE repositorio.voos_2023 (
    empresa_sigla TEXT,
    empresa_nome TEXT,
    empresa_nacionalidade TEXT,
    ano TEXT,
    mes TEXT,
    aeroporto_origem_sigla TEXT,
    aeroporto_origem_nome TEXT,
    aeroporto_origem_uf TEXT,
    aeroporto_origem_regiao TEXT,
    aeroporto_origem_pais TEXT,
    aeroporto_origem_continente TEXT,
    aeroporto_destino_sigla TEXT,
    aeroporto_destino_nome TEXT,
    aeroporto_destino_uf TEXT,
    aeroporto_destino_regiao TEXT,
    aeroporto_destino_pais TEXT,
    aeroporto_destino_continente TEXT,
    natureza TEXT,
    grupo_voo TEXT,
    passageiros_pagos TEXT,
    passageiros_gratis TEXT,
    carga_paga_kg TEXT,
    carga_gratis_kg TEXT,
    correio_kg TEXT,
    ask TEXT,
    rpk TEXT,
    atk TEXT,
    rtk TEXT,
    combustivel_litros TEXT,
    distancia_voada_km TEXT,
    decolagens TEXT,
    carga_paga_km TEXT,
    carga_gratis_km TEXT,
    correio_km TEXT,
    assentos TEXT,
    payload TEXT,
    horas_voadas TEXT,
    bagagem_kg TEXT
);

CREATE TABLE repositorio.voos_2024 (LIKE repositorio.voos_2023 INCLUDING ALL);

CREATE TABLE repositorio.voos_2025 (LIKE repositorio.voos_2023 INCLUDING ALL);