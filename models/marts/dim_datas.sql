with
    stg_dates as (
        select *
        from {{ ref('stg__date2') }}
    )

select *
from stg_dates