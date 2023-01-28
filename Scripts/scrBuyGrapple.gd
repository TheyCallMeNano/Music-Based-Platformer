extends Button


func _on_Button_pressed():
	global.grappleBought = true
	global.score -= 50000
	global.levelComplete = false
	get_tree().change_scene("res://Rooms/Hub.tscn")
