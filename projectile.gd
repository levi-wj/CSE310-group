extends Area2D

@export var speed = 100

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if not body.is_in_group("player"):
		# If we hit anything except ourselves, delete the projectile
		queue_free()
		print("hit something")
