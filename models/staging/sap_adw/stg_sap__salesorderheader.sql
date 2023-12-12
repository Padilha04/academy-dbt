with
source_salesorder as (
    select
    cast(salesorderid as int) as pedidovendas_id
    -- , revisionnumber
    , date(orderdate) as pedidovendas_data
    -- , duedate
    -- , shipdate
    , cast(status as int) as pedidovendas_status
    , cast(onlineorderflag as string) as eh_pedidoonline
    -- , purchaseordernumber
    -- , accountnumber
    , cast(customerid as int) as cliente_id
    , cast (salespersonid as int) as vendedor_id
    , cast(territoryid as int) as territorio_id
    , cast(billtoaddressid as int) as enderecocobranca_id
    -- , shiptoaddressid
    -- , shipmethodid
    , cast(creditcardid as int) as cartaocredito_id
    -- , creditcardapprovalcode
    -- , currencyrateid
    -- , subtotal
    -- , taxamt
    -- , freight
    , cast(totaldue as numeric) as valor_total
    -- , comment
    -- , rowguid
    -- , modifieddate
    from {{ source('sap', 'salesorderheader') }}
)

select *
from source_salesorder