extends CanvasModulate

func _process(delta):
	if Input.is_action_just_pressed("slot3"):
		$AnimationPlayer.play("AddHue")
	if Input.is_action_just_pressed("slot2"):
		$AnimationPlayer.play("RemoveHue")
