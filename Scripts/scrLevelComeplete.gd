extends Area2D

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			global.levelComplete = true
			global.score = int(round(global.score))
			body.position = Vector2(-128,-128)
			body.motion = Vector2(0,0)
