with fudgeflix as (

    select
        'Not Applicable' as payment_type,
        '0' as payment_id,
        'UNKNOWN' as card_network,
         'FudgeFlix' as division
),

fudgemart as (

    select
        'credit card' as payment_type,
        creditcard_id as payment_id,
    CASE
        WHEN creditcard_number LIKE '4%' THEN 'Visa'
        WHEN creditcard_number LIKE '5%' THEN 'Mastercard'
        WHEN creditcard_number LIKE '34%' OR creditcard_number LIKE '37%' THEN 'American Express'
        WHEN creditcard_number LIKE '6%' THEN 'Discover'
        ELSE 'Other'
    END as card_network,
        'FudgeMart' as division

    from {{ source('fudgemart_v3','fm_creditcards') }}

),

all_payments as (

    select * from fudgeflix 
    union all
    select * from fudgemart
    
    )



select
    {{ dbt_utils.generate_surrogate_key(['payment_id']) }} as payment_method_key,
    *
from all_payments