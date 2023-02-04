extends Sprite

func _process(delta):
	if global.slot2 == 1:
		self.visible = true
		set_frame(3)
	elif global.slot2 == 0:
		self.visible = false
