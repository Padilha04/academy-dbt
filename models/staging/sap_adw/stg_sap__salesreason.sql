with
    source_salesreason as (
        select
            cast(salesreasonid as int) as razaovenda_id
            , cast(name as string) as razaovenda_nome
            , cast(reasontype as string) as razaovenda_tipo
            -- , modifieddate

        from {{ source('sap', 'salesreason') }}
    )

select *
from source_salesreason