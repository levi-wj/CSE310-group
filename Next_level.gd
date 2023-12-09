extends Area2D

var level_names = ["Winter_1", "Fall_Level2", "Spring_Level_3"]

	





func _on_body_entered(body):
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int()
		print(next_level_number)
		var next_level_path = "res://Levels/" + level_names[next_level_number] + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
		
