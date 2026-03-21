with f_fact_sales as (
    select * from {{ ref('fact_sale') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_product as (
    select * from {{ ref('dim_product') }}
),
d_payment_method as (
    select * from {{ ref('dim_payment_method') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)
select 
    d_customer.customer_key, d_customer.customer_id,d_customer.customer_email,d_customer.customer_firstname,
    d_customer.customer_lastname,d_customer.customer_address,d_customer.customer_city,d_customer.customer_state,
    d_customer.customer_zip,d_customer.customer_phone,d_customer.customer_fax,
    d_product.product_key,d_product.product_id,d_product.product_name,d_product.product_is_active,
    d_product.product_start_date,d_product.product_department,d_product.product_vendor_name,
    d_payment_method.payment_method_key,d_payment_method.payment_type,d_payment_method.payment_id,d_payment_method.card_network,
    d_date.*,
    fs.order_id,fs.order_date_key,fs.order_quantity,fs.unit_selling_price,fs.unit_cost_price, 
    fs.order_sold_amount,fs.order_cost_amount,fs.order_profit,fs.order_profit_margin,fs.division
    from f_fact_sales as fs
    left join d_customer on fs.customer_key = d_customer.customer_key
    left join d_product on fs.product_key=d_product.product_key
    left join d_payment_method on fs.payment_method_key = d_payment_method.payment_method_key
    left join d_date on fs.order_date_key = d_date.date_key
