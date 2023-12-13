with

    loja_endereco as (
        select *
        from {{ ref('stg_sap__businessentityaddress') }}

    )

    , vendedor as (
        select *
        from {{ ref('stg_sap__salesperson') }}

    )

    , join_tabelas_loja as (
        select
            vendedor.vendedor_id
            , loja_endereco.endereco_id

        from loja_endereco
        left join vendedor on loja_endereco.loja_id = vendedor.vendedor_id
    )

    select *
    from join_tabelas_loja
    where vendedor_id is not null