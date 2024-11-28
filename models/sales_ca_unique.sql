{{ dbt_utils.deduplicate(
    relation=source('training', 'sales_ca'),
    partition_by='sales_date',
    order_by="sales_date",
   )
}}