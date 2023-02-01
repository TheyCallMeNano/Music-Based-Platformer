extends Area2D

var isColliding = false

func _on_Grapple_body_entered(body):
	isColliding = true

func _on_Grapple_body_exited(body):
	isColliding = false

func _process(delta):
	if isColliding == true:
		if Input.is_action_pressed("interact"):
			if global.credits >= 500000 && global.grappleBought == false:
				global.credits -= 500000
				global.grappleBought = true
			global.levelComplete = false


