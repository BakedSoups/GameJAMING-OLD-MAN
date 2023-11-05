extends Node



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.hooked = true
		queue_free()
	pass # Replace with function body.
