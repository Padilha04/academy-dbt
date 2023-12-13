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
        , sap_person.pessoa_nome_completo
        from sap_customers
        left join sap_person on sap_customers.pessoa_id = sap_person.pessoa_id
        )


select *
from join_tabelas_clientes
