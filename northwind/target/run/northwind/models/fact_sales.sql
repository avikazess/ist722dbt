
  
    

create or replace transient table analytics.dbt_avikazess_northwind.fact_sales
    
    
    
    as (with stg_orders as 
(
    select
        OrderID,  
        md5(cast(coalesce(cast(customerid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as customerkey, 
        md5(cast(coalesce(cast(employeeid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as employeekey, 
        replace(to_date(orderdate)::varchar,'-','')::int as orderdatekey,
        from raw.northwind.Orders
),
stg_order_details as
(
    select 
        orderid,
        md5(cast(coalesce(cast(productid as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as productkey,
        Quantity,
        Quantity*UnitPrice as extendedpriceamount,
        Discount*(Quantity*UnitPrice) as discountamount,
        Discount*(Quantity*UnitPrice) - Discount as soldamount
        from raw.northwind.Order_Details

)

select  
    o.*,
    od.productkey,od.Quantity,od.extendedpriceamount,od.discountamount,od.soldamount
from stg_orders o
   join stg_order_details od on o.orderid = od.orderid
    )
;


  