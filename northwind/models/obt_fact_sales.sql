with f_fact_sales as (
    select * from {{ ref('fact_sales') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_product as (
    select * from {{ ref('dim_product') }}
),
d_employee as (
    select * from {{ ref('dim_employee') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)
select 
    d_customer.*, 
    d_product.*,
    d_employee.*, 
    d_date.*,
    fs.orderid, fs.orderdatekey,fs.Quantity, fs.extendedpriceamount,fs.discountamount,fs.soldamount
    from f_fact_sales as fs
    left join d_customer on fs.customerkey = d_customer.customerkey
    left join d_product on fs.productkey=d_product.productkey
    left join d_employee on fs.employeekey = d_employee.employeekey
    left join d_date on fs.orderdatekey = d_date.datekey
