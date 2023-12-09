with
    source_stateprovince as (
        select
        cast(stateprovinceid as int) as estado_id
        , cast(stateprovincecode as string) as estado_codigo
        , cast (countryregioncode as string) as pais_codigo
        -- , isonlystateprovinceflag
        , cast(name as string) as estado_nome
        , cast(territoryid as int) as territorio_id
        -- , rowguid
        -- , modifieddate
        from {{ source('sap', 'stateprovince') }}
    )
select *
from source_stateprovince