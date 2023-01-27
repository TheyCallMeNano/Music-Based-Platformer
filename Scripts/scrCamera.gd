extends Camera2D

func _process(delta):
	if get_parent().motion.y > 300 || get_parent().motion.x > 300 || get_parent().motion.x < -10:
		if zoom.x < 0.6:
			zoom.x += .0005
			zoom.y += .0005
	elif get_parent().motion.y < get_parent().speed || get_parent().motion.x < get_parent().speed:
		if zoom.x != 0.4:
			zoom.x -= 0.003
			zoom.y -= 0.003
		if zoom.x < 0.4:
			zoom.x = 0.4
			zoom.y = 0.4
