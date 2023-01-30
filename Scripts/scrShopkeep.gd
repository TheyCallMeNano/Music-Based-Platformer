extends Area2D

func _on_Area2D_body_entered(body):
	print("Colliding")
	if Input.is_action_pressed("interact"):
		global.grappleBought = true
		if global.credits >= 50000 && global.grappleBought == false:
				global.credits -= 50000
		global.levelComplete = false
		global.credits += global.score
		global.score = 100000
