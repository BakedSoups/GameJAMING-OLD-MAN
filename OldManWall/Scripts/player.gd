extends CharacterBody2D


const SPEED = 500.0

var climbing = false
var ladderJump = false

const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 1200

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() && not climbing:
		velocity.y += gravity * delta
	elif climbing:
		if ladderJump:
			velocity.y += gravity * delta
		elif not ladderJump:
			velocity.y = 0
		if Input.is_action_pressed("ui_up"):
			velocity.y = -SPEED
			ladderJump = false
		elif Input.is_action_pressed("ui_down"):
			velocity.y = SPEED
			ladderJump = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif climbing:
			ladderJump = true;
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
