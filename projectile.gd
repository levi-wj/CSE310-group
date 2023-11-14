extends Area2D

class_name Projectile

@export var speed = 100

func _ready():
	body_entered.connect(_on_EnemyBodyEntered)

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if not body.is_in_group("Player"):
		# If we hit anything except ourselves, delete the projectile
		queue_free()
		print("hit something")

func _on_EnemyBodyEntered(body):
	if body.is_in_group("Enemies"):
		body.queue_free()
		queue_free()
