# LivriApp

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


mix phx.new livri-api --app livri_app --module LivriApp --no-html --no-webpack --binary-id

mix phx.gen.json Users User users \
document:string \
username:string \
first_name:string \
last_name:string \
email:string \
phone:string \
password:string

mix phx.gen.json Tasks Task tasks \
user_id:references:users \
name:string \
when:date \
frequency:string \
tags:string \
status:string

mix phx.gen.json Tags Tag tags \
user_id:references:users \
name:string \
color:string \
priority:integer


List the tables in DynamoDB

aws dynamodb list-tables --endpoint-url http://localhost:8000

 
Creates a table

aws dynamodb put-item \
--table-name Music  \
--item \
    '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}}' \
--return-consumed-capacity TOTAL 

aws dynamodb create-table \
    --table-name Music \
    --attribute-definitions \
        AttributeName=Artist,AttributeType=S \
        AttributeName=SongTitle,AttributeType=S \
    --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --endpoint-url http://localhost:8000
    
aws dynamodb create-table \
    --table-name tags \
    --attribute-definitions \
        AttributeName=user_id,AttributeType=S \
        AttributeName=id,AttributeType=S \
    --key-schema AttributeName=user_id,KeyType=HASH AttributeName=id,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --endpoint-url http://localhost:8000
    

aws dynamodb create-table \
    --table-name tags \
    --attribute-definitions \
        AttributeName=id,AttributeType=B \
    --key-schema AttributeName=id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --endpoint-url http://localhost:8000

Add new items

aws dynamodb put-item \
--table-name Music  \
--item \
    '{"Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}, "AlbumTitle": {"S": "Somewhat Famous"}}' \
--return-consumed-capacity TOTAL  

aws dynamodb put-item \
    --table-name Music \
    --item '{ \
        "Artist": {"S": "Acme Band"}, \
        "SongTitle": {"S": "Happy Day"}, \
        "AlbumTitle": {"S": "Songs About Life"} }' \
    --return-consumed-capacity TOTAL \
    --endpoint-url http://localhost:8000


aws dynamodb put-item \
    --table-name Tag \
    --item \
      '{"UserId": {"S": "94f49799-f858-4b8d-adbf-abf1040dff1a"}, "Name": {"S": "Banestes"}, "Color": {"S": "0218A3"}, "Priority": {"N": "1"} }' \
    --return-consumed-capacity TOTAL \
    --endpoint-url http://localhost:8000

aws dynamodb put-item \
    --table-name Tag \
    --item '{ \
        "UserId": {"S": "94f49799-f858-4b8d-adbf-abf1040dff1a"}, \
        "Name": {"S": "Banestes"}, \
        "Color": {"S": "0218A3"}, \
        "Priority": {"N": 1} }' \
    --return-consumed-capacity TOTAL \
    --endpoint-url http://localhost:8000

aws dynamodb query --table-name Music --key-conditions file://aws-db-key-conditions.json --endpoint-url http://localhost:8000

aws dynamodb query --table-name Tag --key-conditions file://aws-tag-key-conditions.json --endpoint-url http://localhost:8000


aws dynamodb get-item --consistent-read \
    --table-name Music \
    --key '{ "Artist": {"S": "No One You Know"}, "SongTitle": {"S": "Call Me Today"}}' \
    --endpoint-url http://localhost:8000