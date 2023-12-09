with
    razaodevenda as (
        select *
        from {{ ref('stg_sap__salesreason') }}
    )
    , headerrazaovenda as (
        select *
        from {{ ref('stg_sap__salesorderheadersalesreason') }}
    )
    , join_tabelas_razoesvendas as (
        select
        razaodevenda.razaovenda_id
        ,  razaodevenda.razaovenda_nome
        ,  razaodevenda.razaovenda_tipo
        ,  headerrazaovenda.pedidovendas_id

        from razaodevenda
        left join headerrazaovenda on razaodevenda.razaovenda_id = headerrazaovenda.razaovenda_id
    )

select *
from join_tabelas_razoesvendas