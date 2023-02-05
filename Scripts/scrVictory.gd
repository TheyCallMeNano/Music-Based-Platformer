extends Area2D

var isColliding = false

func _on_Area2D_body_entered(body):
	isColliding = true

func _on_Grapple_body_exited(body):
	isColliding = false

func _process(delta):
	if isColliding == true:
		$Sprite.set_scale(Vector2(1,1))
		$Particles2D.emitting = true
		$Label.visible = true
		if Input.is_action_just_pressed("interact"):
			if global.credits >= 750000:
				global.credits -= 750000
				get_tree().change_scene("res://Rooms/Victory.tscn")
				$ChaChing.play()
	elif isColliding == false:
		$Sprite.set_scale(Vector2(.5,.5))
		$Label.visible = false
		$Particles2D.emitting = false
		$ChaChing.stop()


