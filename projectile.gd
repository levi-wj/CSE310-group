extends Area2D

@export var speed = 100
@onready var player = get_tree().get_first_node_in_group("Player")

const CUTOFF_DISTANCE = 1000;

func _ready():
	body_entered.connect(_on_EnemyBodyEntered)

func _physics_process(delta):
	position += transform.x * speed * delta
	
	if is_instance_valid(player):
		var distance = global_transform.origin.distance_to(player.global_transform.origin)
		if distance > CUTOFF_DISTANCE:
			queue_free()
	else:
		queue_free()


func _on_Bullet_body_entered(body):
	if not body.is_in_group("Player"):
		# If we hit anything except ourselves, delete the projectile
		queue_free()
		print("hit something")

func _on_EnemyBodyEntered(body):
	if body.is_in_group("Enemies"):
		body.queue_free()
		queue_free()
