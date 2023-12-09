with
    sap_customers as (
        select *
        from {{ ref('stg_sap__customers') }}
    )

select *
from sap_customers
