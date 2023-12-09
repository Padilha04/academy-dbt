with 
    source_product as (
        select
        cast(productid as int) as produto_id
        , cast(name as string) as produto_nome
        -- , productnumber
        -- , makeflag
        -- , finishedgoodsflag
        -- , color
        -- , safetystocklevel
        -- , reorderpoint
        , cast(standardcost as numeric) as preco_padrao
        , cast(listprice as numeric) as preco_lista
        -- , size
        -- , sizeunitmeasurecode
        -- , weightunitmeasurecode
        -- , weight
        -- , daystomanufacture
        -- , productline
        -- , class
        -- , style
        -- , productsubcategoryid
        -- , productmodelid
        -- , sellstartdate
        -- , sellenddate
        -- , discontinueddate
        -- , rowguid
        -- , modifieddate
        from {{ source('sap', 'product') }}
    )

select *
from source_product