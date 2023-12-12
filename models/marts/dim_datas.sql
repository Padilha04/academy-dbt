with
    stg_dates as (
        select *
        from {{ ref('stg__date') }}
    )

select *
from stg_dates