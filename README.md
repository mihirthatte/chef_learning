## Generates Random User Data

This recipe runs a python script which generates random user information and inserts it into an Elasticsearch instance.

##Buiold - 
Run ```kitchen converge``` to apply the confiuration.

Run ```kitchen exec -c 'python /var/tmp/generator/populate_data.py' ``` to generate random user information.

Login to vagrant box - 

``` kitchen login```

Check if the data has been correctly populated to Elasticsearch index - `test/es` by running following command - 
```
curl -XGET "localhost:9200/test_es/users/_search?pretty=true" -H 'Content-Type: application/json' -d'{"query": {"match_all": {}}}'
```

##Verify - 

Use ```kitchen verify``` to run inspec tests
