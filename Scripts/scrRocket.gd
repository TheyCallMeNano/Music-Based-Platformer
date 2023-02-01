extends Area2D

export var speed = 1500
const EXPLOSION = preload("res://Objects/objExplosion.tscn")

func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta


func _on_Rocket_body_entered(_body):
	var explosion = EXPLOSION.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()
