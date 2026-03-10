
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select dayofweek
from analytics.dbt_avikazess_northwind.dim_date
where dayofweek is null



  
  
      
    ) dbt_internal_test