extends Label

func _process(_delta):
	##Print debug variables for in game tracking.
	## This is super messy and requires one giant set_text function decreasing framerate. This is terrible, too bad!
	## Debug key is "F4" (Check Project > Project Settings for all keybindings)
	if Input.is_action_pressed("debugMenu"):
		set_text("FPS: " + str(Performance.get_monitor(Performance.TIME_FPS)) + 
		"\nMouse X/Y: " + str(get_viewport().get_mouse_position()) + 
		"\nEquipped: " + str(global.equipped))
	#Reset text to nothing so that the player doesn't have the debug info
	else:
		set_text("")
