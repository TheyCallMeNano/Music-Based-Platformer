extends Area2D

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player" && global.levelComplete == false:
			global.levelComplete = true
			global.levelStart = false
			global.score = int(round(global.score))
			global.credits += global.score
			global.score = 100000
			$"/root/Hub/Player/ShopPiano".play()
			$"/root/Hub/Player/UnarmedJive".stop()
			body.position = Vector2(-128,-128)
			body.motion = Vector2(0,0)
