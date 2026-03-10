
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select productid
from analytics.dbt_avikazess_northwind.dim_product
where productid is null



  
  
      
    ) dbt_internal_test