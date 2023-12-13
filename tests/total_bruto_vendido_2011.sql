{{
    config (
        severity = 'error'
    )
}}

with
    vendas_brutas_2011 as (
        select 
        sum(total_bruto) as total_bruto_vendido
        from {{ ref('fct_vendas') }}
        where pedidovendas_data between '2011-01-01' and '2011-12-31'
    )

select total_bruto_vendido
from vendas_brutas_2011
where total_bruto_vendido not between 12646111.16 and 12646113.16