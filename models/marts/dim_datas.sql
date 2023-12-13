with
    stg_dates as (
        select 
        id
        , full_date
        , year
        , month
        , month_name
        from {{ ref('stg__date') }}
    )

select *
from stg_dates