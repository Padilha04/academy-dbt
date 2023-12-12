with
    loja as (
        select *
        from {{ ref('stg_sap__store') }}

    )

    , loja_endereco as (
        select *
        from {{ ref('stg_sap__businessentityaddress') }}

    )

    , join_tabelas_loja as (
        select
            loja.loja_id
            , loja.loja_nome
            , loja.vendedor_id
            , loja_endereco.endereco_id
        from loja
        left join loja_endereco on loja.loja_id = loja_endereco.loja_id
    )

    select *
    from join_tabelas_loja