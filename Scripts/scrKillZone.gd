extends Area2D




func _on_KillZone_body_entered(body):
	if body == $"/root/Hub/Player":
		body.motion = Vector2(0,0)
		body.gameOver()
