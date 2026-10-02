{{ config(
    materialized='incremental',
    unique_key='flight_id'
) }}

with flights as (
    select * from {{ ref('int_flights_aggregated') }}
)

select
    flight_id,
    {{ dbt_utils.generate_surrogate_key(['icao24']) }} as aircraft_id,
    callsign,
    flight_date,
    first_seen,
    last_seen,
    min_altitude,
    max_altitude,
    avg_velocity,
    state_count
from flights

{% if is_incremental() %}
    where last_seen > (select coalesce(max(last_seen), '1900-01-01'::timestamp) from {{ this }})
{% endif %}
