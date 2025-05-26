SET search_path TO dw, public;

-- dim_customer -------------------------------------------------------------
INSERT INTO dw.dim_customer
        (first_name, last_name, age, email, country, postal_code)
SELECT DISTINCT
       customer_first_name,
       customer_last_name,
       customer_age,
       customer_email,
       customer_country,
       customer_postal_code
FROM   staging.pet_store_source
WHERE  customer_email IS NOT NULL
ON CONFLICT (email) DO NOTHING;

-- dim_pet ------------------------------------------------------------------
INSERT INTO dw.dim_pet
        (name, type, breed)
SELECT DISTINCT
       customer_pet_name,
       customer_pet_type,
       customer_pet_breed
FROM   staging.pet_store_source
WHERE  customer_pet_name IS NOT NULL
ON CONFLICT (name, type) DO NOTHING;

-- dim_product --------------------------------------------------------------
INSERT INTO dw.dim_product
        (product_name, supplier_name, category, brand,
         size, colour, price, weight)
SELECT DISTINCT
       product_name,
       supplier_name,
       product_category,
       product_brand,
       product_size,
       product_color,
       product_price,
       product_weight
FROM   staging.pet_store_source
WHERE  product_name IS NOT NULL
ON CONFLICT (product_name, supplier_name) DO NOTHING;

-- dim_store ----------------------------------------------------------------
INSERT INTO dw.dim_store
        (store_name, email, city, state, country, phone)
SELECT DISTINCT
       store_name,
       store_email,
       store_city,
       store_state,
       store_country,
       store_phone
FROM   staging.pet_store_source
WHERE  store_email IS NOT NULL
ON CONFLICT (email) DO NOTHING;

TRUNCATE dw.fact_sales;

INSERT INTO dw.fact_sales (
    customer_key, pet_key, product_key, store_key,
    sale_date, quantity, total_price
)
SELECT
    c.customer_key,
    p.pet_key,
    pr.product_key,
    s.store_key,
    t.sale_date,
    t.sale_quantity,
    t.sale_total_price
FROM   staging.pet_store_source AS t
JOIN   dw.dim_customer AS c
  ON   LOWER(TRIM(c.email)) = LOWER(TRIM(t.customer_email))
JOIN   dw.dim_pet AS p
  ON   p.name = t.customer_pet_name
 AND   p.type = t.customer_pet_type
JOIN   dw.dim_product AS pr
  ON   pr.product_name  = t.product_name
 AND   pr.supplier_name = t.supplier_name
JOIN   dw.dim_store AS s
  ON   LOWER(TRIM(s.email)) = LOWER(TRIM(t.store_email));

CREATE INDEX IF NOT EXISTS idx_dim_customer_email
        ON dw.dim_customer (LOWER(TRIM(email)));

CREATE INDEX IF NOT EXISTS idx_dim_pet_name_type
        ON dw.dim_pet (name, type);

CREATE INDEX IF NOT EXISTS idx_dim_product_name_supplier
        ON dw.dim_product (product_name, supplier_name);

CREATE INDEX IF NOT EXISTS idx_dim_store_email
        ON dw.dim_store (LOWER(TRIM(email)));
