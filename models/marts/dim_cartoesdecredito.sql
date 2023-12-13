with
    sap_creditcards as (
        select *
        from {{ ref('stg_sap__creditcard') }}

    )

select *
from sap_creditcards