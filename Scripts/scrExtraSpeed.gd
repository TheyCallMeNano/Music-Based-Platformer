extends Area2D

var isColliding = false

func _on_Area2D_body_entered(body):
	isColliding = true

func _on_ExtraSpeed_body_exited(body):
	isColliding = false

func _process(delta):
	if isColliding == true:
		$Sprite.set_scale(Vector2(.4,.4))
		$Particles2D.emitting = true
		if Input.is_action_just_pressed("interact"):
			if global.credits >= 50000 && global.speedMultiplier != 300:
				global.credits -= 50000
				global.speedMultiplier += 100
				$Sprite.frame += 1
				$ChaChing.play()
	elif isColliding == false:
		$Sprite.set_scale(Vector2(.3,.3))
		$Particles2D.emitting = false
		$ChaChing.stop()
