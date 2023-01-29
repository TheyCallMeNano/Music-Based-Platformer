extends Button


func _on_Button_pressed():
	global.grappleBought = true
	if global.credits == 50000 && global.grappleBought == false || global.credits > 50000 && global.grappleBought == false:
		global.credits -= 50000
	global.levelComplete = false
	global.credits += global.score
	global.score = 100000
	get_tree().change_scene("res://Rooms/Hub.tscn")
