with
    sap_customers as (
        select *
        from {{ ref('stg_sap__customers') }}
    )

    , sap_person as (
        select *
        from {{ ref('stg_sap__person') }}
    )

    , join_tabelas_clientes as (
        select
        sap_customers.cliente_id
        , sap_customers.pessoa_id
        , sap_customers.loja_id
        , case 
            when sap_customers.pessoa_id is null then cast("Cliente" || " " || cliente_id as string)
            else pessoa_nome_completo
        end as nome_do_cliente
        from sap_customers
        left join sap_person on sap_customers.pessoa_id = sap_person.pessoa_id
        )


select *
from join_tabelas_clientes
