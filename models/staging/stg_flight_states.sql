{{ config(materialized='view') }}

with source as (
    select * from {{ source('public', 'flight_states') }}
),

renamed as (
    select
        id,
        trim(icao24) as icao24,
        trim(callsign) as callsign,
        trim(origin_country) as origin_country,
        to_timestamp(time_position) as position_timestamp,
        to_timestamp(last_contact) as contact_timestamp,
        longitude,
        latitude,
        baro_altitude,
        on_ground,
        velocity,
        true_track,
        vertical_rate,
        geo_altitude,
        squawk,
        spi,
        position_source,
        to_timestamp(api_timestamp) as api_timestamp,
        ingested_at,
        updated_at
    from source
)

select * from renamed
