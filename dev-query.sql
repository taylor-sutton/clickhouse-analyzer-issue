SELECT
    COLUMNS('.')
EXCEPT
    (timestamp, value),
    groupArray(tuple(timestamp, value)) as values
FROM
    (
        SELECT
            toDateTime('2025-03-20 12:25:40') as timestamp,
            avg(toFloat64OrNull(attributes [ 'utilization' ]) as _val) as value
        FROM
            default .app_logs_dev_ue1 as _logs_table
        WHERE
            _logs_table.timestamp BETWEEN '2025-03-20 12:25:40' AND '2025-03-20 12:35:40'
            AND (
                env = 'production'
                AND service = 'sd2'
                AND title = 'event-loop-utilization'
            )
            AND _val IS NOT NULL
        GROUP BY
            ALL
        ORDER BY
            timestamp ASC
    )
GROUP BY ALL
-- SETTINGS
    -- allow_experimental_analyzer = 1
    -- when this is 0, the query has no results
    -- when this is 1, the query returns one row: [('2025-03-20 12:25:40',NULL)]
