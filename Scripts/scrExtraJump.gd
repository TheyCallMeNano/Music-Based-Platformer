extends Area2D

var isColliding = false

func _on_Area2D_body_entered(body):
	isColliding = true

func _on_ExtraJump_body_exited(body):
	isColliding = false

func _ready():
	if global.jumpMultiplier == 1.5:
		$Sprite.frame = 3
	elif global.jumpMultiplier == 2:
		$Sprite.frame = 4
	elif global.jumpMultiplier == 2.5:
		$Sprite.frame = 5

func _process(delta):
	if isColliding == true:
		$Sprite.set_scale(Vector2(.4,.4))
		$Particles2D.emitting = true
		$Label.visible = true
		if Input.is_action_just_pressed("interact"):
			if global.credits >= 50000 && global.jumpMultiplier != 2.5:
				global.credits -= 50000
				global.jumpMultiplier += .5
				$Sprite.frame += 1
				$ChaChing.play()
	elif isColliding == false:
		$Sprite.set_scale(Vector2(.3,.3))
		$Label.visible = false
		$Particles2D.emitting = false
		$ChaChing.stop()
	
	if Input.is_action_just_pressed("resetLevel") && $Sprite.frame != 4:
		$Sprite.frame -= 1
