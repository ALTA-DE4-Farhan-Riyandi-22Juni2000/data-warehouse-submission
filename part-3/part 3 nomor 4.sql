WITH placement AS (
    SELECT
        shardid as shard_id
        , nodename as node_name
    FROM pg_dist_shard_placement
),  order_shards as (
	select order_id
	, get_shard_id_for_distribution_column('orders', order_id) as shard_id
	, 'orders_' || get_shard_id_for_distribution_column('orders', order_id) as real_table_name
	from orders
	where order_id=13
)
select order_shards.*, placement.node_name
from order_shards 
inner join placement on placement.shard_id = order_shards.shard_id