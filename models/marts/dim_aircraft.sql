{{ config(materialized='table') }}

with flight_states as (
    select * from {{ ref('stg_flight_states') }}
),

distinct_aircraft as (
    select
        icao24,
        max(origin_country) as origin_country,
        max(position_timestamp) as last_seen
    from flight_states
    where icao24 is not null
    group by 1
)

select
    {{ dbt_utils.generate_surrogate_key(['icao24']) }} as aircraft_id,
    icao24,
    origin_country,
    last_seen
from distinct_aircraft
