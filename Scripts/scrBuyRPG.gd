extends Area2D

var isColliding = false

func _on_Area2D_body_entered(body):
	isColliding = true

func _on_RPG_body_exited(body):
	isColliding = false

func _process(delta):
	if isColliding == true:
		if Input.is_action_pressed("interact"):
			if global.credits >= 500000 && global.grappleBought == false:
				global.credits -= 500000
				global.rpgBought = true
			global.levelComplete = false
