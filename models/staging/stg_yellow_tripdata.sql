{{ config(materialized='view') }}

SELECT 
    -- identifiers
    CAST(VendorID AS INTEGER) AS vendorid
    ,CAST(RatecodeID AS INTEGER) AS ratecodeid
    ,CAST(PULocationID AS INTEGER) AS pickup_locationid
    ,CAST(DOLocationID AS INTEGER) AS dolocationid

    -- timestamp
    ,CAST(tpep_pickup_datetime AS TIMESTAMP) AS pickup_datetime
    ,CAST(tpep_dropoff_datetime AS TIMESTAMP) AS dropoff_datetime

    -- trip info
    ,store_and_fwd_flag
    ,CAST(passenger_count AS INTEGER) AS passenger_count
    ,CAST(trip_distance AS NUMERIC) AS trip_distance

    -- payment info
    ,CAST(fare_amount AS NUMERIC) AS fare_amount
    ,CAST(extra AS NUMERIC) AS extra
    ,CAST(mta_tax AS NUMERIC) AS mta_tax
    ,CAST(tip_amount AS NUMERIC) AS tip_amount
    ,CAST(tolls_amount AS NUMERIC) AS tolls_amount
    ,CAST(improvement_surchage AS NUMERIC) AS improvement_surchage
    ,CAST(payment_type AS INTEGER) AS payment_type
    ,{{ get_payment_type_description(payment_type)}} AS payment_type_desc
    ,CAST(congestion_surcharge AS INTEGER) AS congestion_surcharge
    ,CAST(airport_fee AS INTEGER) AS airport_fee
 FROM {{ source('staging', 'yellow_trip') }}
LIMIT 100