with
    source_person as (
        select
        cast(businessentityid as int) as pessoa_id
        -- , persontype
        -- , namestyle
        -- , title
        , cast(firstname as string) as pessoa_nome
        -- , middlename
        , cast(lastname as string) as pessoa_sobrenome
        , cast (firstname || " " || lastname as string) as pessoa_nome_completo
        -- , suffix
        -- , emailpromotion
        -- , additionalcontactinfo
        -- , demographics
        -- , rowguid
        -- , modifieddate
        from {{ source('sap', 'person') }}
    )

    select *
    from source_person