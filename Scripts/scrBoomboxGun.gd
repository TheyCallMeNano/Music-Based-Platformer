extends Sprite

var mpos = Vector2()
var pos = Vector2()
var rot

func _process(delta):
	mpos = get_global_mouse_position()
	pos = global_position
	
	look_at(get_global_mouse_position())
	
	rot = rad2deg((mpos - pos).angle())
	
	if(rot >= -90 and rot <= 90):
		flip_v = false
	else:
		flip_v = true

