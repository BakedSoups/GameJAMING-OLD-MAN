extends CharacterBody2D


var SPEED = 500.0

@onready var animator = $AnimatedSprite2D

var climbing = false
var ladderJump = false

var doubleJump = true

var dashing = false
var lr = 1
var hasFired = false

var JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 1200

var hook = preload("res://GameObjects/grappling_hook.tscn")
var h

var wing = preload("res://GameObjects/wings.tscn")
var w
var winged = false

var age = 0
const YOUNG_SPEED = 800
const ADULT_SPEED = 500
const OLD_SPEED = 200
const YOUNG_JUMP = -800
const ADULT_JUMP = 500
const OLD_JUMP = 200

func _ready():
	ageMod()

func ageMod():
	if age == 0:
		SPEED = YOUNG_SPEED
		JUMP_VELOCITY = YOUNG_JUMP
		winged = true
	elif age == 1:
		SPEED = ADULT_SPEED
		JUMP_VELOCITY = ADULT_JUMP
		winged = false
	elif age == 2:
		SPEED = OLD_SPEED
		JUMP_VELOCITY = OLD_JUMP
		winged = true

func shoot():
	if Input.is_key_pressed(KEY_Z) and not dashing and not hasFired:
		hasFired = true
		velocity.y = 0
		dashing = true
		h = hook.instantiate()
		h.position = Vector2(position.x, position.y - 40)
		get_parent().add_child(h)
		
func bodyFun():
	if winged:
		w = wing.instantiate()
		w.position = Vector2(position.x, position.y)
		add_child(w)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left") and not dashing:
		lr = -1
	elif Input.is_action_just_pressed("ui_right") and not dashing:
		lr = 1
	shoot()
	if not dashing:
		if is_on_floor() or climbing:
			doubleJump = true
			hasFired = false
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
			elif doubleJump and winged:
				doubleJump = false
				velocity.y = JUMP_VELOCITY
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			if lr != 1: 
				animator.flip_h = true
			else:
				animator.flip_h = false
			animator.play("Walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			##idle animationm 
			animator.play("Idle")

		move_and_slide()
