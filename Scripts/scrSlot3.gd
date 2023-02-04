extends Sprite

func _process(_delta):
	if global.slot3 == 1:
		self.visible = true
		set_frame(0)
	elif global.slot3 == 0:
		self.visible = false
		set_frame(0)
