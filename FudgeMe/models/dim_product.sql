with ff_plans as (

    select
        plan_id as product_id,
        plan_name as product_name,
        plan_current as product_is_active,
        TO_DATE('1900-01-01') as product_start_date,
        'fudgeflix_subscriptions' as product_department,
        '-1' as product_vendor_name,
        'FudgeFlix' as division
    from {{ source('fudgeflix_v3','ff_plans') }} 

),

fm_products as (

    select
        product_id,
        product_name,
        product_is_active,
        TO_DATE(TO_TIMESTAMP(product_add_date / 1000000)) AS product_start_date,
        product_department,
        z.vendor_name as product_vendor_name,
        'FudgeMart' as division
    from {{ source('fudgemart_v3','fm_products') }} a

     left join {{ source('fudgemart_v3','fm_vendors') }} z
        on a.product_vendor_id = z.vendor_id

),

all_products as (

    select * from ff_plans
    union all
    select * from fm_products

)

select
    {{ dbt_utils.generate_surrogate_key(['division','product_id']) }} as product_key,
    *
from all_products