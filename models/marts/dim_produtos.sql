with
    sap_products as (
        select *
        from {{ ref('stg_sap__product') }}
    )

select *
from sap_products