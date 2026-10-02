{{ config(
    materialized='table'
) }}

with staging as (
    select * from {{ ref('stg_flight_states') }}
),

aggregated as (
    select
        icao24,
        callsign,
        origin_country,
        date(position_timestamp) as flight_date,
        min(position_timestamp) as first_seen,
        max(position_timestamp) as last_seen,
        min(baro_altitude) as min_altitude,
        max(baro_altitude) as max_altitude,
        avg(velocity) as avg_velocity,
        count(id) as state_count
    from staging
    where icao24 is not null
    group by 1, 2, 3, 4
)

select
    {{ dbt_utils.generate_surrogate_key(['icao24', 'callsign', 'flight_date']) }} as flight_id,
    *
from aggregated
