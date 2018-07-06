# random_users

TODO: Enter the cookbook description here.

kitchen exec -c 'python /var/tmp/generator/populate_data.py'

curl -XGET "localhost:9200/test_es/users/_search?pretty=true" -H 'Content-Type: application/json' -d'{"query": {"match_all": {}}}'

