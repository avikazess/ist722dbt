
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select discountamount
from analytics.dbt_avikazess_northwind.fact_sales
where discountamount is null



  
  
      
    ) dbt_internal_test