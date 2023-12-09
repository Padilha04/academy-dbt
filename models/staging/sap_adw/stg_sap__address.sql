
with
    source_address as (
        select
            cast(addressid as int) as endereco_id
            -- , addressline1
            -- , addressline2
            , cast(city as string) as cidade
            , cast(stateprovinceid as int) as estado_id
            -- , postalcode
            -- , spatiallocation
            -- , rowguid
            -- , modifieddate
        from {{ source('sap', 'address') }}
    )

select *
from source_address