
#!/bin/sh
echo "< - - - Bundling data - - - >"

curl -s -XPUT -H 'Content-Type: application/json' http://localhost:9200/_template/test -d @/data.json
