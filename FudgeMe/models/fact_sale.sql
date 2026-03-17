with dim_customer as (

    select * from {{ ref('dim_customer') }}

),

 dim_payment_method as (

    select * from {{ ref('dim_payment_method') }}
),

dim_product as (

    select * from {{ ref('dim_product') }}

),

 ff as (

    select
        cast(fab.ab_id as integer) as order_id,
        replace(to_date(to_timestamp(fab.ab_date/1000000))::varchar,'-','')::int as order_date_key,
        dc.customer_key,
        dp.product_key,
        pm.payment_method_key,
        1 as order_quantity,
        cast(fpa.plan_price as number (12,4)) as unit_selling_price,
        cast(fpa.plan_price/2 as number (12,4)) as unit_cost_price,
        cast(fab.ab_billed_amount as number (12,4))as order_sold_amount,
        cast(fab.ab_billed_amount/2 as number (12,4))as order_cost_amount,
        cast(fab.ab_billed_amount-(fab.ab_billed_amount/2)as number (12,4)) as order_profit,
        cast(((fab.ab_billed_amount-(fab.ab_billed_amount/2))/ fab.ab_billed_amount)as number (7,4))  as order_profit_margin,
        'fudgeflix' as division
    from {{ source('fudgeflix_v3','ff_plans') }}  fpa 

    join {{ source('fudgeflix_v3','ff_account_billing') }} fab 
        on fab.ab_plan_id=fpa.plan_id 

    join dim_customer dc
        on fab.ab_account_id=dc.customer_id
        and dc.division='fudgeflix'
    join dim_product dp
        on dp.division = 'fudgeflix'
    join dim_payment_method pm
        on pm.division = 'fudgeflix'
),


fm as (

    select
         a.order_id,
         replace(to_date(to_timestamp(order_date/1000000))::varchar,'-','')::int as order_date_key,
         dc.customer_key,
         dp.product_key,
         pm.payment_method_key,
         b.order_qty as order_quantity,
         cast(pr.product_retail_price as number (12,4))  as unit_selling_price,
         cast(pr.product_wholesale_price as number (12,4)) as unit_cost_price,
         cast(b.order_qty*pr.product_retail_price as number (12,4)) as order_sold_amount,
         cast(b.order_qty*pr.product_wholesale_price as number (12,4)) as order_cost_amount,
         cast((b.order_qty*pr.product_retail_price)-(b.order_qty*pr.product_wholesale_price) as number (12,4)) as order_profit,
         cast(((b.order_qty*pr.product_retail_price)-(b.order_qty*pr.product_wholesale_price)) / 
         nullif((b.order_qty*pr.product_retail_price),0) as number (9,4)) as order_profit_margin,
         'fudgemart' as division
    from {{ source('fudgemart_v3','fm_orders') }} a

    left join {{ source('fudgemart_v3','fm_creditcards') }} cc
        on a.creditcard_id=cc.creditcard_id

     join {{ source('fudgemart_v3','fm_order_details') }} b
        on a.order_id = b.order_id 
    left join {{ source('fudgemart_v3','fm_products') }} pr 
        on b.product_id=pr.product_id

    join dim_customer dc
        on a.customer_id = dc.customer_id
        and dc.division = 'fudgemart'

    join dim_product dp
        on pr.product_id = dp.product_id
        and dp.division = 'fudgemart'

    join dim_payment_method pm
        on pm.division = 'fudgemart'
),

all_sales as (

  select * from ff
  union all
  select * from fm 

)


select
    *
from all_sales 



