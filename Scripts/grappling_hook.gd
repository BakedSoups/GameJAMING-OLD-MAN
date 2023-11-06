extends Area2D

var dash = false
var pos1
var setPos = false

const HOOK_SPEED = 30
const PLAYER_SPEED = 20
const LENGTH = 750

func hookDash():
	var p = get_parent().get_node("Player")
	p.doubleJump = true
	p.dashing = true
	p.velocity.y = 0
	p.position.x  += p.lr * PLAYER_SPEED
	if abs(p.position.x - position.x) < 100:
		queue_free()
		p.dashing = false
		p.hasFired = false

func _physics_process(delta):
	var p = get_parent().get_node("Player")
	if not setPos:
		pos1 = position
		setPos = true
	if not dash:
		position.x += p.lr * HOOK_SPEED
		if p.lr == 1:
			get_node("Sprite2D").set_flip_h(false)
		else:
			get_node("Sprite2D").set_flip_h(true)
	elif dash:
		hookDash()
	if abs(position.x - pos1.x) > LENGTH:
		queue_free()
		p.dashing = false
	

func _on_body_entered(body):
	var p = get_parent().get_node("Player")
	if body.is_in_group("Border"):
		queue_free()
		p.dashing = false
	elif body.is_in_group("Wall") and not dash:
		dash = true
	elif body.is_in_group("Player") and dash and not p.is_on_wall():
		queue_free()
		p.dashing = false
		p.hasFired = false
		
	pass # Replace with function body.
