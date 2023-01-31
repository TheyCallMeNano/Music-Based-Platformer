extends Area2D

export var speed = 15000000

func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
