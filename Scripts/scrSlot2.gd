extends Sprite

func _process(delta):
	if global.slot2 == 1:
		set_frame(3)
	elif global.slot2 == 0:
		set_frame(0)
