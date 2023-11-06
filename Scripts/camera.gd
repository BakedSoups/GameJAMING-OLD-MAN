extends Camera2D

var py = position.y

var currPos = 0
var maxPos = 0

var ost1 = preload("res://sounds/theme-slowest.mp3")
var ost2 = preload("res://sounds/theme-slow.mp3")
var ost3 = preload("res://sounds/theme-normal.mp3")
var isPlaying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_zoom(get_zoom() - Vector2(0.25, 0.25))

func musicCheck():
	if maxPos == 0 and not isPlaying:
		$AudioStreamPlayer2D.stream = ost1
		$AudioStreamPlayer2D.play()
		isPlaying = true
	elif maxPos == 1 and not isPlaying:
		var pos = $AudioStreamPlayer2D.get_playback_position()
		$AudioStreamPlayer2D.stream = ost2
		$AudioStreamPlayer2D.play(pos)
		isPlaying = true
	elif maxPos == 2 and not isPlaying:
		var pos = $AudioStreamPlayer2D.get_playback_position()
		$AudioStreamPlayer2D.stream = ost3
		$AudioStreamPlayer2D.play(pos)
		isPlaying = true

func _physics_process(delta):
	musicCheck()
	var p = get_parent().get_node("Player")
	if abs(p.position.y - position.y) >700:
		if (p.position.y < position.y):
			position.y -= 1400
			currPos+=1
			if currPos > maxPos:
				maxPos = currPos
				isPlaying = false
				musicCheck()
		else:
			position.y += 1400
			currPos-=1
	#comment ehre
