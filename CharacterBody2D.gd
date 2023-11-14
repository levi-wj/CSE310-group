extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var MAX_BULLETS = 2
@export var BULLET_KNOCKBACK = 100
@export var CAMERA_LEFT_LIMIT = -100
@export var CAMERA_TOP_LIMIT =-500
@export var CAMERA_RIGHT_LIMIT =700
@export var CAMERA_BOTTOM_LIMIT = 200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var bullets_left = 0
var x_knockback = 0

@onready var _animated_sprite = $AnimatedSprite2D
@onready var fireball = preload("res://fireball.tscn")
@onready var camera = $Camera2D

func _ready():
	_update_camera()

func _update_camera():
	camera.limit_left = CAMERA_LEFT_LIMIT
	camera.limit_top = CAMERA_TOP_LIMIT
	camera.limit_right = CAMERA_RIGHT_LIMIT
	camera.limit_bottom = CAMERA_BOTTOM_LIMIT

func _physics_process(delta):
	var onfloor = is_on_floor()

	# Add the gravity.
	if not onfloor:
		velocity.y += gravity * delta
		_animated_sprite.play("jump")
	else:
		bullets_left = MAX_BULLETS
		
	# Handle bullets
	if bullets_left > 0:
		if Input.is_action_just_pressed("bullet_down"):
			velocity.y += (BULLET_KNOCKBACK * -1) - (velocity.y)
			bullets_left -= 1
			shoot(90)
		elif Input.is_action_just_pressed("bullet_up"):
			velocity.y += BULLET_KNOCKBACK
			bullets_left -= 1
			shoot(270)
		elif Input.is_action_just_pressed("bullet_left"):
			x_knockback = BULLET_KNOCKBACK
			bullets_left -= 1
			shoot(180)
		elif Input.is_action_just_pressed("bullet_right"):
			x_knockback = BULLET_KNOCKBACK * -1
			bullets_left -= 1
			shoot(0)

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Walk player left and right and play animations
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = (direction * SPEED) + x_knockback
		if direction > 0:
			_animated_sprite.flip_v = false
		else:
			_animated_sprite.flip_v = true
		if onfloor:
			_animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) + x_knockback
		if onfloor:
			_animated_sprite.play("idle")
	
	x_knockback = lerpf(x_knockback, 0, .3)
	
	
	
	move_and_slide()

func shoot(direction):
	var fireball_instance = fireball.instantiate()
	get_tree().get_root().add_child(fireball_instance)
	fireball_instance.transform.origin = transform.origin
	fireball_instance.rotation = deg_to_rad(direction)


func _on_area_2d_area_entered(area):
	if area.is_in_group("deathBox"):
		get_tree().reload_current_scene()
