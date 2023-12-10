extends Node

@onready var ui_row = preload("res://highscore_row.tscn")

var data_raw = {
	"collection":"high_score_data",
	"database":"high_score",
	"dataSource":"Cluster0",
	"sort": {"score":1},
	"limit": 10	
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var json = JSON.stringify(data_raw)
	var headers = ["Content-Type: application/json","Access-Control-Request-Headers: *","api-key: VOII2w3SVRVHq8vQ3m9L6he86He45zXRA8efsRYDyWMXhADSNYaNJdH1DRp0hUKs"]
	var data_request = $HTTPRequest.request("https://us-west-2.aws.data.mongodb-api.com/app/data-hicfs/endpoint/data/v1/action/find", headers, HTTPClient.METHOD_POST,json)
	

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	var container = $"../MarginContainer/Highscore/VBoxContainer2";
	
	for score in json.documents:
		var instance = ui_row.instantiate()
		instance.get_node("Panel").get_node("Label").text = str(score.score);
		container.add_child(instance)
