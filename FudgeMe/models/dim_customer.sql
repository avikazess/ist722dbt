with ff_accounts as (

    select
        account_id as customer_id,
        account_email as customer_email,
        account_firstname as customer_firstname,
        account_lastname as customer_lastname,
        account_address as customer_address,
        z.zip_city as customer_city,
        z.zip_state as customer_state,
        account_zipcode as customer_zip,
        '-1' as customer_phone,
        '-1' as customer_fax,
        'FudgeFlix' as division

    from {{ source('fudgeflix_v3','ff_accounts') }} a
    left join {{ source('fudgeflix_v3','ff_zipcodes') }} z
        on a.account_zipcode = z.zip_code

),

fm_customers as (

    select
        customer_id,
        customer_email,
        customer_firstname,
        customer_lastname,
        customer_address,
        customer_city,
        customer_state,
        customer_zip,
        customer_phone,
        customer_fax,
        'FudgeMart' as division

    from {{ source('fudgemart_v3','fm_customers') }}

),

all_customers as (

    select * from ff_accounts 
    union all
    select * from fm_customers
    
    )



select
    {{ dbt_utils.generate_surrogate_key(['division','customer_id']) }} as customer_key,
    *
from all_customers