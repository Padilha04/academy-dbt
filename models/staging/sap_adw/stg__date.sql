with
    date_spine as (
        {{ dbt_utils.date_spine(
            start_date="cast('2011-01-01' as date)",
            datepart="day",
            end_date="cast('2014-12-31' as date)"
         )
        }}
    )
    , create_date_parts as (
        select
            date_day
            , cast(date_day as date) as date_actual
            , {{ dbt_date.day_name("date_day", short=true) }} as day_name_short
            , {{ dbt_date.day_name("date_day", short=false) }} as day_name_long
            , {{ dbt_date.month_name("date_day", short=true) }} as month_name_short
            , {{ dbt_date.month_name("date_day") }} as month_name
            , {{ dbt_date.date_part("week", "date_day") }} as week_actual
            , {{ dbt_date.date_part("month", "date_day") }} as month_actual
            , {{ dbt_date.date_part("year", "date_day") }} as year_actual
            , {{ dbt_date.date_part("quarter", "date_day") }} as quarter_actual
            , {{ dbt_date.day_of_week("date_day") }} + 1 as day_of_week
            , {{ dbt_date.day_of_month("date_day") }} as day_of_month
            , {{ dbt_date.day_of_year("date_day") }} as day_of_year
            , {{ dbt.date_trunc("month", "date_day") }} as first_day_of_month
            , {{ dbt.date_trunc("week", "date_day") }} as first_day_of_week
            , {{ dbt.date_trunc("year", "date_day") }} as first_day_of_year
            , {{ dbt.date_trunc("quarter", "date_day") }} as first_day_of_quarter
        from date_spine
    )

    , add_windown_and_case as (
        select
            *
            , {{ dbt_date.periods_since("date_actual", period_name="day", tz="UTC") }} as day_desc_index
            , {{ dbt_date.periods_since("date_actual", period_name="month", tz="UTC") }} as month_desc_index
            , {{ dbt_date.periods_since("date_actual", period_name="year", tz="UTC") }} as year_desc_index
            , {{ dbt.last_day("date_actual", "week") }} as last_day_of_week
            , {{ dbt.last_day("date_actual", "month") }} as last_day_of_month
            , {{ dbt.last_day("date_actual", "year") }} as last_day_of_year
            , {{ dbt.last_day("date_actual", "quarter") }} as last_day_of_quarter

            , row_number() over (
                partition by
                    year_actual
                    , quarter_actual
                order by
                    date_day
                )
            as day_of_quarter
            , case
                when day_name_short = 'Sun'
                    then week_actual + 1
                else week_actual
            end as week_of_year_temp
        from create_date_parts
    )

    , date_diff_columns as (
        select
            *
            , case
                when day_name_short = 'Sun'
                    and lead(week_of_year_temp) over (order by date_day) = '1'
                    then '1'
                else week_of_year_temp
            end as week_of_year
            , {{ dbt.datediff("first_day_of_month", "last_day_of_month", "day") }} as days_in_month_count
            , {{ dbt_date.date_part("day", "last_day_of_month") }} - day_of_month as days_until_last_day_of_month
        from add_windown_and_case
    )

    , add_surrogate_key as (
        select
            {{ dbt_utils.generate_surrogate_key(
                    ['date_actual']
                )
            }} as date_sk
            , *
        from date_diff_columns
    )

select *
from add_surrogate_key
