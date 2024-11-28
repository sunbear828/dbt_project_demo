{{config(materialized='incremental', unique_key='ORDERID')}}
SELECT 
    OrderID,
    OrderDate,
    CustomerID,
    EmployeeID,
    StoreID,
    Status AS StatusCD,
    CASE 
        WHEN Status = '1' THEN 'Pending'
        WHEN Status = '2' THEN 'Processing'
        WHEN Status = '3' THEN 'Cancelled'
        WHEN Status = '4' THEN 'Delivered'
        WHEN Status = '5' THEN 'Shipped'
        ELSE NULL
    END AS StatusDesc,
    Updated_at,
    current_timestamp as dbt_updated_at
FROM 
    {{source('landing','ordr')}}

{% if is_incremental() %}
where Updated_at >= (select max(dbt_updated_at) from {{this}})
{% endif %}