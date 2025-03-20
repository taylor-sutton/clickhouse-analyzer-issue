CREATE TABLE default.app_logs_dev_ue1
(
    `timestamp` DateTime DEFAULT toStartOfSecond(timestamp_ms) CODEC(DoubleDelta, LZ4),
    `timestamp_ms` DateTime64(3) CODEC(DoubleDelta),
    `service` LowCardinality(String),
    `env` LowCardinality(String),
    `title` LowCardinality(String),
    `attributes` Map(LowCardinality(String), String),
)
PARTITION BY toDate(timestamp)
PRIMARY KEY (-toUnixTimestamp(timestamp), service)
ORDER BY (-toUnixTimestamp(timestamp), service, -toUnixTimestamp64Milli(timestamp_ms))
TTL timestamp + toIntervalDay(60)
