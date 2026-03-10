
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select shipcountry
from analytics.dbt_avikazess_northwind.fact_order_fulfillment
where shipcountry is null



  
  
      
    ) dbt_internal_test