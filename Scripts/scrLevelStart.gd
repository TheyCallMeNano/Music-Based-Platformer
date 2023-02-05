extends Area2D

func _process(_delta):
	var bodies = get_overlapping_bodies()
	if global.levelStart == false:
		$CollisionShape2D.disabled = false
		$ShopDoor.visible = false
		$ShopDoor.collision_layer = 2
		$ShopDoor.collision_mask = 2
	for body in bodies:
		if body.name == "Player":
			global.levelStart = true
			global.levelComplete = false
			$CollisionShape2D.disabled = true
			$"/root/Hub/Player/UnarmedJive".play()
			$"/root/Hub/Player/MusicPlayer".play("FadeToUnarmed")


func _on_LevelStart_body_exited(body):
	$ShopDoor.visible = true
	$ShopDoor.collision_layer = 1
	$ShopDoor.collision_mask = 1
