
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select quarter
from analytics.dbt_avikazess_northwind.dim_date
where quarter is null



  
  
      
    ) dbt_internal_test