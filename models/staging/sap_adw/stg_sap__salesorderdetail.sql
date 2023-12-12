with 
    source_salesorderdetail as (
        select
        cast(salesorderid as int) as pedidovendas_id
        , cast(salesorderdetailid as int) as detalhespedidovendas_id
        -- , carriertrackingnumber
        , cast(orderqty as int) as unidade_quantidade
        , cast(productid as int) as produto_id
        , cast(specialofferid as int) as ofertaespecial_id
        , cast(unitprice as numeric) as unidade_preco
        , cast(unitpricediscount as numeric) as unidade_desconto
        -- , rowguid
        --, modifieddate
        from {{ source('sap', 'salesorderdetail') }}

    )

select *
from source_salesorderdetail