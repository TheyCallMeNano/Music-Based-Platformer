extends Camera2D


func _process(delta):
	if get_parent().motion.x > 300:
		zoom.x += .00005
		zoom.y += .00002
	elif get_parent().motion.x < get_parent().speed:
		if zoom.x != 0.4:
			zoom.x -= 0.0005
			zoom.y -= 0.0002
		if zoom.x < 0.4:
			zoom.x = 0.4
			zoom.y = 0.4
