-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

create table "customers" (
    "customer_id" text,
    "customer_unique_id" text not null,
    "customer_zip_code_prefix" integer not null,
    "customer_city" text not null,
    "customer_state" text not null,
    primary key("customer_id")
);

create table "sellers" (
    "seller_id" text,
    "seller_zip_code_prefix" integer not null,
    "seller_city" text not null,
    "seller_state" text not null,
    primary key("seller_id")
);

create table "products" (
    "product_id" text,
    "product_category_name" text not null,
    "product_name_lenght" integer not null,
    "product_description_lenght" integer not null,
    "product_photos_qty" integer not null,
    "product_weight_g" integer not null,
    "product_length_cm" integer not null,
    "product_height_cm" integer not null,
    "product_width_cm" integer not null,
    primary key("product_id")
);

create table "orders" (
    "order_id" text,
    "customer_id" text not null,
    "order_status" text not null,
    "order_purchase_timestamp" text not null,
    "order_approved_at" text,
    "order_delivered_carrier_date" text,
    "order_delivered_customer_date" text,
    "order_estimated_delivery_date" text not null,
    foreign key("customer_id") references "customers"("customer_id"),
    primary key("order_id")
);

create table "order_items" (
    "order_id" text,
    "order_item_id" integer not null,
    "product_id" text,
    "seller_id" text,
    "shipping_limit_date" text not null,
    "price" real not null,
    "freight_value" real not null,
    foreign key("order_id") references "orders"("order_id"),
    foreign key("product_id") references "products"("product_id"),
    foreign key("seller_id") references "sellers"("seller_id"),
    primary key("order_id", "order_item_id")
);

create table "payments" (
    "order_id" text,
    "payment_sequential" integer not null,
    "payment_type" text not null,
    "payment_installments" integer not null,
    "payment_value" real not null,
    foreign key("order_id") references "orders"("order_id"),
    primary key("order_id", "payment_sequential")
);

create table "reviews" (
    "review_id" text,
    "order_id" text,
    "review_score" integer not null,
    "review_comment_title" text,
    "review_comment_message" text,
    "review_creation_date" text not null,
    "review_answer_timestamp" text,
    foreign key("order_id") references "orders"("order_id"),
    primary key("review_id")
);

-- Index to speed up queries filtering/aggregating order_items by seller and price
create index "order_items_sellers_id" on "order_items" ("seller_id", "price");

-- Index to speed up review lookups by order
create index "review_order_id" on "reviews" ("order_id", "review_score");

-- Index to speed up order lookups by customer id
create index "orders_customer_id" on "orders" ("customer_id", "order_id");

-- Index to speed up product lookups by product category name
create index "products_product_category_name" on "products"("product_category_name");

-- View showing the top 10 best_selling product categories
create view "top_10_product_categories" as
select "product_category_name", count("product_category_name") as "total_products" from "products"
group by "product_category_name"
order by count("product_category_name") desc
limit 10;


-- View showing average order value group by customer state
create view "average_order_value_by_state" as
select "customer_state", sum("price") / count(distinct"orders"."order_id") as "Average_Order_Value_By_State"
from "customers"
join "orders" on "customers"."customer_id" = "orders"."customer_id"
join "order_items" on "orders"."order_id" = "order_items"."order_id"
group by "customer_state"
order by "average order value by state";
