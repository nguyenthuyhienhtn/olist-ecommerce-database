-- Top 10 sellers by revenue
select "sellers"."seller_id", sum("price") as "Total Revenue" from "sellers"
join "order_items" on "order_items"."seller_id" = "sellers"."seller_id"
group by "sellers"."seller_id"
order by "Total Revenue" desc
limit 10;


-- 5 sellers have the best average review scores
select "sellers"."seller_id", avg("review_score") as "Average Review Score"
from "sellers"
join "order_items" on "sellers"."seller_id" = "order_items"."seller_id"
join "reviews" on "order_items"."order_id" = "reviews"."order_id"
group by "sellers"."seller_id"
order by "Average Review Score" desc
limit 5;


-- 5 sellers have the worst average review scores
select "sellers"."seller_id", avg("review_score") as "Average Review Score"
from "sellers"
join "order_items" on "sellers"."seller_id" = "order_items"."seller_id"
join "reviews" on "order_items"."order_id" = "reviews"."order_id"
group by "sellers"."seller_id"
order by "Average Review Score"
limit 5;

-- 50 repeat customers
select "customer_unique_id", count("order_id") as "Total_Orders" from "customers"
join "orders" on "customers"."customer_id" = "orders"."customer_id"
group by "customer_unique_id"
order by count("order_id") desc
limit 50;

-- top 10 product categories that sold the most
select "product_category_name", count("product_category_name") as "Total_Products" from "products"
group by "product_category_name"
order by count("product_category_name") desc
limit 10;

-- average order value by state
select "customer_state", sum("price") / count(distinct"orders"."order_id") as "Average Order Value By State"
from "customers"
join "orders" on "customers"."customer_id" = "orders"."customer_id"
join "order_items" on "orders"."order_id" = "order_items"."order_id"
group by "customer_state"
order by "average order value by state";

-- Example: create a new order, mark it as delivered
insert into "orders" ("order_id", "customer_id", "order_status", "order_purchase_timestamp", "order_estimated_delivery_date")
values (
    'test_order_001',
    (select "customer_id" from "customers" limit 1),
    'processing',
    '2026-08-18 12:15:00',
    '2026-08-22'
);

update "orders"
set "order_status" = 'delivered'
where "order_id" = 'test_order_001';

-- Example: create a new order, mark it as canceled, then remove it from the database
insert into "orders" ("order_id", "customer_id", "order_status", "order_purchase_timestamp", "order_estimated_delivery_date")
values (
    'test_order_002',
    (select "customer_id" from "customers" limit 1),
    'processing',
    '2026-08-18 12:39:00',
    '2026-08-22'
);

update "orders"
set "order_status" = 'canceled'
where "order_id" = 'test_order_002';

delete from "orders"
where "order_id" = 'test_order_002';

