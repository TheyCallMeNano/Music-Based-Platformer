extends CanvasModulate

func _process(delta):
	if Input.is_action_just_pressed("slot3") && global.grappleBought == true:
		$AnimationPlayer.play("AddHue")
	if Input.is_action_just_pressed("slot2") && global.rpgBought == true:
		$AnimationPlayer.play("RemoveHue")
