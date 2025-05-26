/* staging без id */

CREATE SCHEMA IF NOT EXISTS staging;

CREATE TABLE IF NOT EXISTS staging.pet_store_source (
    customer_first_name      TEXT,
    customer_last_name       TEXT,
    customer_age             INT,
    customer_email           TEXT,
    customer_country         TEXT,
    customer_postal_code     TEXT,
    customer_pet_type        TEXT,
    customer_pet_name        TEXT,
    customer_pet_breed       TEXT,
    seller_first_name        TEXT,
    seller_last_name         TEXT,
    seller_email             TEXT,
    seller_country           TEXT,
    seller_postal_code       TEXT,
    product_name             TEXT,
    product_category         TEXT,
    product_price            NUMERIC(12,2),
    product_quantity         INT,
    sale_date                DATE,
    sale_customer_id         INT,
    sale_seller_id           INT,
    sale_product_id          INT,
    sale_quantity            INT,
    sale_total_price         NUMERIC(12,2),
    store_name               TEXT,
    store_location           TEXT,
    store_city               TEXT,
    store_state              TEXT,
    store_country            TEXT,
    store_phone              TEXT,
    store_email              TEXT,
    pet_category             TEXT,
    product_weight           NUMERIC(12,3),
    product_color            TEXT,
    product_size             TEXT,
    product_brand            TEXT,
    product_material         TEXT,
    product_description      TEXT,
    product_rating           NUMERIC(3,1),
    product_reviews          INT,
    product_release_date     DATE,
    product_expiry_date      DATE,
    supplier_name            TEXT,
    supplier_contact         TEXT,
    supplier_email           TEXT,
    supplier_phone           TEXT,
    supplier_address         TEXT,
    supplier_city            TEXT,
    supplier_country         TEXT
);

\echo '--- COPY mock_data1_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data1_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data2_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data2_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data3_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data3_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data4_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data4_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data5_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data5_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data6_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data6_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data7_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data7_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data8_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data8_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data9_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data9_no_id.csv'  WITH (FORMAT csv, HEADER true);

\echo '--- COPY mock_data10_no_id.csv ---'
COPY staging.pet_store_source FROM '/data/mock_data10_no_id.csv' WITH (FORMAT csv, HEADER true);

-- 4. Быстрая проверка: после инициализации увидишь сообщение с количеством строк
\echo '--- Проверка: количество строк в staging ---'
SELECT COUNT(*) AS raw_rows FROM staging.pet_store_source;