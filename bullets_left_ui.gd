extends MarginContainer

@onready var hbox = $HBoxContainer;
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var fireball = preload("res://fireball_ui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.bullets_left_changed.connect(_on_bullets_left_changed)
	
func _on_bullets_left_changed(amt):
	var children = hbox.get_children()
	for c in children:
		hbox.remove_child(c)
	for i in amt:
		var instance = fireball.instantiate()
		hbox.add_child(instance)
