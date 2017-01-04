--
-- MULTI_TENANT_ISOLATION
--
-- Tests tenant isolation feature
--

SET citus.shard_replication_factor TO 1;
SET citus.shard_count to 2;

CREATE TABLE lineitem_streaming  (
	l_orderkey bigint not null,
	l_partkey integer not null,
	l_suppkey integer not null,
	l_linenumber integer not null,
	l_quantity decimal(15, 2) not null,
	l_extendedprice decimal(15, 2) not null,
	l_discount decimal(15, 2) not null,
	l_tax decimal(15, 2) not null,
	l_returnflag char(1) not null,
	l_linestatus char(1) not null,
	l_shipdate date not null,
	l_commitdate date not null,
	l_receiptdate date not null,
	l_shipinstruct char(25) not null,
	l_shipmode char(10) not null,
	l_comment varchar(44) not null);
SELECT create_distributed_table('lineitem_streaming', 'l_orderkey');

CREATE TABLE orders_streaming  (
	o_orderkey bigint not null,
	o_custkey integer not null,
	o_orderstatus char(1) not null,
	o_totalprice decimal(15,2) not null,
	o_orderdate date not null,
	o_orderpriority char(15) not null,
	o_clerk char(15) not null,
	o_shippriority integer not null,
	o_comment varchar(79) not null);
SELECT create_distributed_table('orders_streaming', 'o_orderkey');

\copy lineitem_streaming FROM '/Users/metindoslu/Workspace/citus/src/test/regress/data/lineitem.1.data' with delimiter '|'
\copy lineitem_streaming FROM '/Users/metindoslu/Workspace/citus/src/test/regress/data/lineitem.2.data' with delimiter '|'
\copy orders_streaming FROM '/Users/metindoslu/Workspace/citus/src/test/regress/data/orders.1.data' with delimiter '|'
\copy orders_streaming FROM '/Users/metindoslu/Workspace/citus/src/test/regress/data/orders.2.data' with delimiter '|'
