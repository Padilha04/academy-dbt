with
    source_salesperson as (
        select
            cast(businessentityid as int) as vendedor_id
            -- , territoryid
            -- , salesquota
            -- , bonus
            -- , commissionpct
            -- , salesytd
            -- , saleslastyear
            -- , rowguid
            -- , modifieddate

        from {{ source('sap', 'salesperson') }}
    )

select *
from source_salesperson

