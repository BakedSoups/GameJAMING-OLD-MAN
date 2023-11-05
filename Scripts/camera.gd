extends Camera2D

var py = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	set_zoom(get_zoom() - Vector2(0.25, 0.25))

func _physics_process(delta):
	var p = get_parent().get_node("Player")
	if abs(p.position.y - position.y) > 1250:
		if (p.position.y < position.y):
			position.y -= 2250
		else:
			position.y += 2250
	#comment ehre
