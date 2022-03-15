
#!/bin/sh



echo "< - - - Creating index - - - >"

curl -s -XPUT -H 'Content-Type: application/json' http://localhost:9200/company -d @/index.json

echo "< - - - Inserting data - - - >"

curl -XPUT localhost:9200/company/_doc/_bulk -H "Content-Type: application/x-ndjson" --data-binary @/bulk_data.json

