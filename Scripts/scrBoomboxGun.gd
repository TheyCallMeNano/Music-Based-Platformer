extends Sprite

var mpos = Vector2()
var pos = Vector2()
var rot

func _process(_delta):
	
	if global.slot3 == 1 && global.equipped == [0,0,1]:
		set_frame(4)
	elif global.slot3 == 0 && global.equipped == [0,0,1]:
		set_frame(0)
	elif global.equipped != [0,0,1] && global.equipped != [0,1,0]:
		set_frame(0)
	elif global.slot2 == 1 && global.equipped == [0,1,0]:
		set_frame(8)
	
	mpos = get_global_mouse_position()
	pos = global_position
	
	look_at(get_global_mouse_position())
	
	rot = rad2deg((mpos - pos).angle())
	
	if(rot >= -90 and rot <= 90):
		flip_v = false
	else:
		flip_v = true

