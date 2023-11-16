extends CharacterBody2D

const SPEED = 50.0
@export var DIRECTION = -1
@export var DETECTS_EDGE = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if DIRECTION == 1:
		$AnimatedSprite2D.flip_h = true
	$GroundCheck.position.x = $CollisionShape2D.shape.get_size().x / 2 * DIRECTION
	$GroundCheck.enabled = DETECTS_EDGE


func _physics_process(delta):
	
	if is_on_wall() or not $GroundCheck.is_colliding() and DETECTS_EDGE and is_on_floor():
		DIRECTION *= -1
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		$GroundCheck.position.x = $CollisionShape2D.shape.get_size().x / 2 * DIRECTION
	
	if is_on_floor():
		$AnimatedSprite2D.play("walk")
	else:
		velocity.y += GRAVITY * delta
	
	velocity.x = DIRECTION * SPEED

	move_and_slide()
