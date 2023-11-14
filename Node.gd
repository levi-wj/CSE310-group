extends Node
var data = {
	"collection":"high_score_data",
	"database":"high_score",
	"dataSource":"Cluster0",
	"document": {
	  "status": "open",
	  "score": "12324"
	}
	
}


func _ready():
	
	var json = JSON.stringify(data)
	var headers = ["Content-Type: application/json","Access-Control-Request-Headers: *","api-key: VOII2w3SVRVHq8vQ3m9L6he86He45zXRA8efsRYDyWMXhADSNYaNJdH1DRp0hUKs"]
	var data_request = $HTTPRequest.request("https://us-west-2.aws.data.mongodb-api.com/app/data-hicfs/endpoint/data/v1/action/insertOne", headers, HTTPClient.METHOD_POST,json)






# Called when the node enters the scene tree for the first time.
#func _ready():
	#$HTTPRequest.request_completed.connect(_on_request_completed)
	#var json = JSON.stringify(data)
	#var headers = ["Content-Type: application/json","Access-Control-Request-Headers: *","api-key: VOII2w3SVRVHq8vQ3m9L6he86He45zXRA8efsRYDyWMXhADSNYaNJdH1DRp0hUKs"]
	#var data_request = $HTTPRequest.request("https://us-west-2.aws.data.mongodb-api.com/app/data-hicfs/endpoint/data/v1/action/findOne", headers, HTTPClient.METHOD_POST,json)
	#print(data_request)
	

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json)
	print("hello")
	


#curl --location --request POST 'https://us-west-2.aws.data.mongodb-api.com/app/data-hicfs/endpoint/data/v1/action/findOne' \
#--header 'Content-Type: application/json' \
#--header 'Access-Control-Request-Headers: *' \
#--header 'api-key: VOII2w3SVRVHq8vQ3m9L6he86He45zXRA8efsRYDyWMXhADSNYaNJdH1DRp0hUKs' \
#--data-raw '{
   # "collection":"listingsAndReviews",
	#"database":"sample_airbnb",
	#"dataSource":"Cluster0"
#}'
	
