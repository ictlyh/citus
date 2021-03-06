--
-- MULTI_MX_TPCH_QUERY6
--


ALTER SEQUENCE pg_catalog.pg_dist_shardid_seq RESTART 1250000;
ALTER SEQUENCE pg_catalog.pg_dist_jobid_seq RESTART 1250000;

-- connect to the coordinator
\c - - - :master_port

-- Change configuration to treat lineitem and orders tables as large

SET citus.large_table_shard_count TO 2;

-- Query #6 from the TPC-H decision support benchmark

SELECT
	sum(l_extendedprice * l_discount) as revenue
FROM
	lineitem_mx
WHERE
	l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1 year'
	and l_discount between 0.06 - 0.01 and 0.06 + 0.01
	and l_quantity < 24;

-- connect to one of the worker nodes
\c - - - :worker_1_port

ALTER SEQUENCE pg_catalog.pg_dist_shardid_seq RESTART 1250000;
ALTER SEQUENCE pg_catalog.pg_dist_jobid_seq RESTART 1250000;

-- Change configuration to treat lineitem and orders tables as large

SET citus.large_table_shard_count TO 2;

-- Query #6 from the TPC-H decision support benchmark

SELECT
	sum(l_extendedprice * l_discount) as revenue
FROM
	lineitem_mx
WHERE
	l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1 year'
	and l_discount between 0.06 - 0.01 and 0.06 + 0.01
	and l_quantity < 24;

-- connect to the other worker node
\c - - - :worker_2_port

ALTER SEQUENCE pg_catalog.pg_dist_shardid_seq RESTART 1250000;
ALTER SEQUENCE pg_catalog.pg_dist_jobid_seq RESTART 1250000;

-- Change configuration to treat lineitem and orders tables as large

SET citus.large_table_shard_count TO 2;

-- Query #6 from the TPC-H decision support benchmark

SELECT
	sum(l_extendedprice * l_discount) as revenue
FROM
	lineitem_mx
WHERE
	l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1 year'
	and l_discount between 0.06 - 0.01 and 0.06 + 0.01
	and l_quantity < 24;
