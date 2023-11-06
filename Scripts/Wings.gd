extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.winged = true
		#var p = get_parent().get_node("Camera2D").get_node("Sprite2D")
		#var hook = preload("res://GameObjects/BootsIcon.tscn")
		#var h
		#h = hook.instantiate()
		#h.position = Vector2(position.x + 975, position.y - 275)
		#h.scale.x = 1
		#h.scale.y = 1
		#p.add_child(h)
		var a = get_parent().get_node("Camera2D").get_node("Sprite2D").get_node("BootsIcon")
		a.visible = true
		queue_free()
	pass # Replace with function body.
