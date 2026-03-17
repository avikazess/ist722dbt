with fudgeflix as (

    select
        'Not Applicable' as payment_method,
        '-1' as payment_creditcard_id,
        'UNKNOWN' as payment_creditcard_number,
        to_date('1900-01-01') as payment_creditcard_exp_date,
        'FudgeFlix' as division
),

fudgemart as (

    select
        'credit card' as payment_method,
        creditcard_id as payment_creditcard_id,
        creditcard_number as payment_creditcard_number,
        creditcard_exp_date as payment_creditcard_exp_date,
        'FudgeMart' as division

    from {{ source('fudgemart_v3','fm_creditcards') }}

),

all_payments as (

    select * from fudgeflix 
    union all
    select * from fudgemart
    
    )



select
    {{ dbt_utils.generate_surrogate_key(['division','payment_creditcard_id']) }} as payment_method_key,
    *
from all_payments