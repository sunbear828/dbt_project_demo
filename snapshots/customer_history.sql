{% snapshot customers_history %}

{{ 
    config(
        target_schema='l3_consumption',
        unique_key='CUSTOMERID',
        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes= True
    ) 
}}

SELECT * FROM {{ source('landing', 'cust') }}

{% endsnapshot %}