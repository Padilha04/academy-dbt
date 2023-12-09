with 
    endereco as (
        select *
        from {{ ref('stg_sap__address') }}
    )

    , estado as (
        select *
        from {{ ref('stg_sap__stateprovince') }}
    )

    , territorio as (
        select *
        from {{ ref('stg_sap__salesterritory') }}
    )

    , join_tabelas_locais as (
        select 
            endereco.endereco_id
            , endereco.cidade
            , estado.estado_id
            , estado.estado_codigo
            , estado.estado_nome
            , territorio.territorio_id
            , territorio.territorio_nome
            , territorio.pais_codigo
        from estado
        left join endereco on estado.estado_id = endereco.estado_id
        left join territorio on territorio.territorio_id = estado.territorio_id
    )

    select *
    from join_tabelas_locais