with 
    source_salesterritory as (
        select
        cast(territoryid as int) as territorio_id
        , cast(name as string) as territorio_nome
        , cast(countryregioncode as string) as pais_codigo
        -- , group
        , cast(salesytd as numeric) as vendas_ytd
        , cast (saleslastyear as numeric) as vendas_lastyear
        -- , costytd
        -- , costlastyear
        -- , rowguid
        -- , modifieddate
        from {{ source('sap', 'salesterritory') }}
)
select *
from source_salesterritory