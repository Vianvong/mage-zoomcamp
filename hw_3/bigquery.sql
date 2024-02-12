-- 1
select count(1)
from `dtc-de-412516.hw_3.green_taxi_2022`;

-- 2
SELECT count(distinct(PULocationID)) FROM `dtc-de-412516.hw_3.green_taxi_2022`;
SELECT count(distinct(PULocationID)) FROM `dtc-de-412516.hw_3.green_taxi_2022_external`;

-- 3
select count(1)
from `dtc-de-412516.hw_3.green_taxi_2022_v1`
where fare_amount = 0;

-- 4
CREATE OR REPLACE TABLE hw_3.green_taxi_partitoned_clustered
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID AS
SELECT * FROM `dtc-de-412516.hw_3.green_taxi_2022`;

-- 5
SELECT distinct(PULocationID)
FROM `dtc-de-412516.hw_3.green_taxi_2022`
where DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT distinct(PULocationID)
FROM `dtc-de-412516.hw_3.green_taxi_partitoned_clustered`
where DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';
