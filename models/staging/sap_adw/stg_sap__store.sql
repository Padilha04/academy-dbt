with 
    source_store as (
        select
        cast(businessentityid as int) as loja_id
        , cast(name as string) as loja_nome
        -- , salespersonid
        -- , demographics
        -- , rowguid
        -- , modifieddate
        from {{ source('sap', 'store') }}
    )

select *
from source_store