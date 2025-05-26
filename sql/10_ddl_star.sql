CREATE SCHEMA IF NOT EXISTS dw;

-- ▸ dim_customer -----------------------------------------------------------
CREATE TABLE IF NOT EXISTS dw.dim_customer (
    customer_key  BIGSERIAL PRIMARY KEY,
    first_name    TEXT,
    last_name     TEXT,
    age           INT,
    email         TEXT UNIQUE,
    country       TEXT,
    postal_code   TEXT
);

-- ▸ dim_pet ----------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dw.dim_pet (
    pet_key  BIGSERIAL PRIMARY KEY,
    name     TEXT,
    type     TEXT,
    breed    TEXT,
    UNIQUE (name, type)
);

-- ▸ dim_product ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dw.dim_product (
    product_key    BIGSERIAL PRIMARY KEY,
    product_name   TEXT,
    supplier_name  TEXT,
    category       TEXT,
    brand          TEXT,
    size           TEXT,
    colour         TEXT,
    price          NUMERIC(12,2),
    weight         NUMERIC(12,3),
    UNIQUE (product_name, supplier_name)
);

-- ▸ dim_store --------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dw.dim_store (
    store_key   BIGSERIAL PRIMARY KEY,
    store_name  TEXT,
    email       TEXT UNIQUE,
    city        TEXT,
    state       TEXT,
    country     TEXT,
    phone       TEXT
);

CREATE TABLE IF NOT EXISTS dw.fact_sales (
    sales_key    BIGSERIAL PRIMARY KEY,
    customer_key BIGINT REFERENCES dw.dim_customer,
    pet_key      BIGINT REFERENCES dw.dim_pet,
    product_key  BIGINT REFERENCES dw.dim_product,
    store_key    BIGINT REFERENCES dw.dim_store,
    sale_date    DATE,
    quantity     INT,
    total_price  NUMERIC(12,2)
);
