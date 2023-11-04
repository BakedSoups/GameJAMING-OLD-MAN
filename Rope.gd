extends Area2D




func _on_body_entered(body):
	if body.is_in_group("Player"):
		if body.climbing == false:
			body.climbing = true
			body.ladderJump = false;
	pass # Replace with function body.



func _on_body_exited(body):
	if body.is_in_group("Player"):
		if body.climbing == true:
			body.climbing = false
			body.ladderJump = false;
	pass # Replace with function body.
