extends Sprite

var mousepositoion

func _process(delta):
	mousepositoion = get_local_mouse_position()
	rotation+= mousepositoion.angle() * 0.1
