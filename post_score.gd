extends Node

var data = {
	"collection":"high_score_data",
	"database":"high_score",
	"dataSource":"Cluster0",
	"document": {
		"score": GlobalTimer.get_score()
	}
}


func _ready():
	GlobalTimer.stop_timer()
	$"../MarginContainer/Highscore/VBoxContainer2/title/Panel/Label".text = "Your score was: %d" % GlobalTimer.get_score()
	var json = JSON.stringify(data)
	var headers = ["Content-Type: application/json","Access-Control-Request-Headers: *","api-key: VOII2w3SVRVHq8vQ3m9L6he86He45zXRA8efsRYDyWMXhADSNYaNJdH1DRp0hUKs"]
	var data_request = $HTTPRequest.request("https://us-west-2.aws.data.mongodb-api.com/app/data-hicfs/endpoint/data/v1/action/insertOne", headers, HTTPClient.METHOD_POST,json)
