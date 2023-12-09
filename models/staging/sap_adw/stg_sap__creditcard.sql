with 
    source_creditcard as (
        select
        cast(creditcardid as int) as cartaocredito_id
        , cast(cardtype as string) as cartaocredito_tipo
        -- , cardnumber
        -- , expmonth
        -- , expyear
        -- , modifieddate
        from {{ source('sap', 'creditcard') }}
    )

select *
from source_creditcard