WITH placement AS (
    SELECT
        shardid as shard_id
        , nodename as node_name
    FROM pg_dist_shard_placement
),  product_shards as (
	select product_id, name
	, get_shard_id_for_distribution_column('products', product_id) as shard_id
	from products
	where name='Headphones'
)
select product_shards.*, placement.node_name
from product_shards 
inner join placement on placement.shard_id = product_shards.shard_id