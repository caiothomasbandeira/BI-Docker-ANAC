-- 04 — Criar funções auxiliares para conversão

CREATE OR REPLACE FUNCTION repositorio.to_numeric_br(valor TEXT)
RETURNS NUMERIC AS $$
BEGIN
    IF valor IS NULL OR BTRIM(valor) = '' THEN
        RETURN NULL;
    END IF;

    RETURN REPLACE(BTRIM(valor), ',', '.')::NUMERIC;

EXCEPTION
    WHEN invalid_text_representation THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql IMMUTABLE;


CREATE OR REPLACE FUNCTION repositorio.to_integer_br(valor TEXT)
RETURNS INTEGER AS $$
BEGIN
    IF valor IS NULL OR BTRIM(valor) = '' THEN
        RETURN NULL;
    END IF;

    RETURN REPLACE(BTRIM(valor), ',', '.')::NUMERIC::INTEGER;

EXCEPTION
    WHEN invalid_text_representation THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql IMMUTABLE;