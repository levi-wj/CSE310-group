extends CharacterBody2D

@export var speed = 400
@export var jump_velocity = -650
@export var jump_count = 2
@export var grav_multiplier = 2

var current_jumps = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	_apply_gravity(delta)

	# Handle Jump.
	handle_jump()
	handle_movement()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta * grav_multiplier
func handle_jump():
	if is_on_floor(): current_jumps = 0
	if Input.is_action_just_pressed("ui_accept"): 
		if is_on_floor() or current_jumps < jump_count:
			velocity.y = jump_velocity
			current_jumps +=1 
func handle_movement():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		$GFX.flip_h = direction<0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
