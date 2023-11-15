extends MarginContainer

@onready var hbox = $HBoxContainer;
@onready var playergroup = get_tree().get_nodes_in_group("Player")
@onready var fireball = preload("res://fireball_ui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if playergroup:
		playergroup[0].bullets_left_changed.connect(_on_bullets_left_changed)
	else:
		print("Could not find player in scene!")
	
func _on_bullets_left_changed(amt):
	var children = hbox.get_children()
	for c in children:
		hbox.remove_child(c)
	for i in amt:
		var instance = fireball.instantiate()
		hbox.add_child(instance)
