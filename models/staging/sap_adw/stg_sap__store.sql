with 
    source_store as (
        select
        cast(businessentityid as int) as loja_id
        , cast(name as string) as loja_nome
        , cast(salespersonid as int) as vendedor_id
        -- , demographics
        -- , rowguid
        -- , modifieddate
        from {{ source('sap', 'store') }}
    )

select *
from source_store