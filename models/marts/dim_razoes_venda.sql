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
        ,  headerrazaovenda.pedidovendas_id
        ,  razaodevenda.razaovenda_nome
        ,  razaodevenda.razaovenda_tipo
    

        from razaodevenda
        left join headerrazaovenda on razaodevenda.razaovenda_id = headerrazaovenda.razaovenda_id
    )

select *
from join_tabelas_razoesvendas
where pedidovendas_id is not null