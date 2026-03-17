select     
    datekey::int as date_key,
    date as full_date,
    dayname as day_name,
    monthname as month_name,
    quarter,
    year, 
    weekday as is_weekday
    from {{ source('conformed','DateDimension')}}
