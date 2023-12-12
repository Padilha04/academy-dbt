with stg_dates as (
    select
        {{dbt_utils.generate_surrogate_key(['date_actual'])}} as date_id
        , date_actual as date_atual
        , {{dbt_date.day_of_month(date_actual)}} as dia
        , {{dbt_date.day_name(date_actual)}} as dia_da_semana
        , {{dbt_date.month_name(date_actual)}} as mes
        , {{dbt_date.date_part('year', date_actual)}} as ano
    from (
        select generate_series(
            cast('2011-01-01' as date)
            , cast('2014-12-31' as date)
            , interval '1 day'
        )::date as date_actual
    ) as dates
)

select *
from stg_dates