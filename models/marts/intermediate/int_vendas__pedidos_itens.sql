with 
    pedido as (
        select *
        from {{ ref('stg_sap__salesorderheader') }}
    )

    , pedido_itens as (
        select *
        from {{ ref('stg_sap__salesorderdetail') }}
    )

    , join_pedidos_itens as (
        select
        pedido_itens.detalhespedidovendas_id
        , pedido.pedidovendas_id
        , pedido.cliente_id
        , pedido.vendedor_id
        , pedido.territorio_id
        , pedido.enderecocobranca_id
        , pedido_itens.produto_id
        , pedido_itens.ofertaespecial_id
        , pedido.cartaocredito_id

        , pedido.valor_total
        , pedido_itens.unidade_quantidade
        , pedido_itens.unidade_preco
        , pedido_itens.unidade_desconto

        , pedido.pedidovendas_data

        , pedido.pedidovendas_status
        , pedido.eh_pedidoonline


        from pedido_itens
        left join pedido on pedido_itens.pedidovendas_id = pedido.pedidovendas_id
    )


select *
from join_pedidos_itens
