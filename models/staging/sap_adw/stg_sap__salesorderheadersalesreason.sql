with
source_salesorderheadersalesreason as (
    select
        cast(salesorderid as int) as pedidovendas_id
        , cast(salesreasonid as int) as razaovenda_id
        -- , modifieddate
    from {{ source('sap', 'salesorderheadersalesreason') }}
)

select *
from source_salesorderheadersalesreason