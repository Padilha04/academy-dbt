with 
    clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    , produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )

    , razoesdevenda as (
        select *
        from {{ ref('dim_razoesdevenda') }}
    )

    , lojas as (
        select *
        from {{ ref('dim_lojas') }}
    )

    , locais as (
        select *
        from {{ ref('dim_locais') }}
    )

    , cartoesdecredito as (
        select *
        from {{ ref('dim_cartoesdecredito') }}
    )

    , pedido_itens as (
        select *
        from {{ ref('int_vendas__pedidos_itens') }}       
    )

    , joined_tabelas as (
        select
        pedido_itens.detalhespedidovendas_id
        , pedido_itens.pedidovendas_id
        , clientes.cliente_id
        --, pedido_itens.territorio_id
        , pedido_itens.enderecocobranca_id
        , produtos.produto_id
        , razoesdevenda.razaovenda_id
        --, pedido_itens.ofertaespecial_id
        , cartoesdecredito.cartaocredito_id
        , lojas.loja_id
        , lojas.loja_nome
        , lojas.vendedor_id
        , lojas.endereco_id as endereco_loja

        , pedido_itens.valor_total
        , pedido_itens.unidade_quantidade
        , pedido_itens.unidade_preco
        , pedido_itens.unidade_desconto

        , pedido_itens.pedidovendas_data

        , pedido_itens.pedidovendas_status
        , pedido_itens.eh_pedidoonline


        from pedido_itens
        left join clientes on pedido_itens.cliente_id = clientes.cliente_id
        left join produtos on pedido_itens.produto_id = produtos.produto_id
        left join razoesdevenda on pedido_itens.pedidovendas_id = razoesdevenda.pedidovendas_id
        left join lojas on pedido_itens.vendedor_id = lojas.vendedor_id
        left join locais on pedido_itens.enderecocobranca_id = locais.endereco_id
        left join cartoesdecredito on pedido_itens.cartaocredito_id = cartoesdecredito.cartaocredito_id
    )

        , transformacoes as (
        select *
        , (unidade_preco * unidade_quantidade) as total_bruto
        , (unidade_preco * unidade_quantidade) * (1 - unidade_desconto) as total_liquido
        , valor_total / count(*) over (partition by pedidovendas_id) as valor_total_dividido_por_itens
        , case 
                when eh_pedidoonline = 'true' then enderecocobranca_id
                else endereco_loja
            end as endereco_da_venda_id
        from joined_tabelas
    )
    select * 
    from transformacoes