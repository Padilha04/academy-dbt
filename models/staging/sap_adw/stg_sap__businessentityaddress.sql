with 
    source_businessentityaddress as (
        select
            cast(businessentityid as int) as loja_id
            , cast(addressid as int) as endereco_id
            -- , addresstypeid
            -- , rowguid
            -- , modifieddate
        from {{ source('sap', 'businessentityaddress') }}
    )

select *
from source_businessentityaddress