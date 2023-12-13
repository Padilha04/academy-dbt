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
            , estado.estado_id
            , territorio.territorio_id
            , endereco.cidade_nome
  
            --, estado.estado_codigo
            , estado.estado_nome
            , territorio.territorio_nome
            -- , territorio.pais_codigo
        from estado
        left join endereco on estado.estado_id = endereco.estado_id
        left join territorio on territorio.territorio_id = estado.territorio_id
    )

    , transformacoes_pais as (
        select *
        , case
            when territorio_nome = 'Northwest' then 'United States'
            when territorio_nome = 'Northeast' then 'United States'
            when territorio_nome = 'Central' then 'United States'
            when territorio_nome = 'Southwest' then 'United States'
            when territorio_nome = 'Southeast' then 'United States'
            else territorio_nome
        end as pais_nome
        from join_tabelas_locais
    )

    select *
    from transformacoes_pais
    where endereco_id is not null 