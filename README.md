# README

1. In one terminal, run `docker run  --rm -p 18123:8123 -p19000:9000 -e CLICKHOUSE_PASSWORD=changeme --name ch-dev-task --ulimit nofile=262144:262144 -v "${PWD}/initialize-dev.sql:/docker-entrypoint-initdb.d/init.sql" clickhouse:24.10`
2. In another terminal, run `cat dev-query.sql | curl 'http://localhost:18123/?password=changeme&allow_experimental_analyzer=0' --data-binary @-`: it should succeed with no results.
3. Then change the setting: `cat dev-query.sql | curl 'http://localhost:18123/?password=changeme&allow_experimental_analyzer=1' --data-binary @-`: now it should return one result `[('2025-03-20 12:25:40',NULL)]`
