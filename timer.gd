extends Node2D

var running = false

var time = 0
var minutes = 0
var seconds = 0


func _process(delta):
	if running:
		time += delta
		seconds = fmod(time, 60)
		minutes = fmod(time, 3600) / 60
		
		$CanvasLayer/Panel/Label.text = "%02d:%02d" % [minutes, seconds]

func start_timer():
	running = true

func stop_timer():
	running = false

func get_score():
	return int(time)
