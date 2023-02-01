extends KinematicBody2D

var velocity = Vector2(0,0)
var speed = 500
const EXPLOSION = preload("res://Objects/objExplosion.tscn")

func _physics_process(delta):
	pass

func _on_Area2D_body_entered(body):
	var explosion = EXPLOSION.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()
