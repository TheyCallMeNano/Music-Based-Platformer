extends Sprite

func _process(delta):
	if global.slot3 == 1:
		set_frame(4)
	elif global.slot3 == 0:
		set_frame(0)
