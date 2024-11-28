-- Define the expected record counts for each table
{% set expected_counts = {
    'cust': 50,
    'emp': 20,
    'str': 10,
    'sup': 5,
    'prd': 100,
    'ordritms': 100,
    'ordr': 100
} %}

-- Test the count of records in each table
{% for table, expected_count in expected_counts.items() %}
		SELECT '{{ table }}' AS table_name,
            (SELECT COUNT(*) FROM {{ source('landing', table) }}) AS record_count,
            {{ expected_count }} AS expected_count
		WHERE (SELECT COUNT(*) FROM {{ source('landing', table) }}) < {{ expected_count }}
	{% if not loop.last %} UNION ALL {% endif %}
{% endfor %}