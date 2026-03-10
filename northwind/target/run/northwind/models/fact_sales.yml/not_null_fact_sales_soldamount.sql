
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select soldamount
from analytics.dbt_avikazess_northwind.fact_sales
where soldamount is null



  
  
      
    ) dbt_internal_test