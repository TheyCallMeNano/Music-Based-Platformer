extends Area2D

var isColliding = false

func _on_Area2D_body_entered(body):
	isColliding = true

func _on_RPG_body_exited(body):
	isColliding = false

func _process(delta):
	if isColliding == true:
		$Sprite.set_scale(Vector2(1,1))
		$Particles2D.emitting = true
		if Input.is_action_pressed("interact"):
			if global.credits >= 500000 && global.rpgBought == false:
				global.credits -= 500000
				global.rpgBought = true
				$ChaChing.play()
	elif isColliding == false:
		$Sprite.set_scale(Vector2(.5,.5))
		$Particles2D.emitting = false
		$ChaChing.stop()
