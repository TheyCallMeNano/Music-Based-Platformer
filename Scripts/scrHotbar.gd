extends Control


func _process(delta):
	if global.equipped == [0,0,0]:
		visible = false
	elif global.equipped != [0,0,0]:
		visible = true
