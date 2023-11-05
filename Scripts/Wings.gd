extends Area2D




func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.winged = true
		queue_free()
	pass # Replace with function body.
