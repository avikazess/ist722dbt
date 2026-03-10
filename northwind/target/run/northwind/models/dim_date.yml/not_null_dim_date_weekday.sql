
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select weekday
from analytics.dbt_avikazess_northwind.dim_date
where weekday is null



  
  
      
    ) dbt_internal_test