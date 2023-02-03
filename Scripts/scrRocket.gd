extends KinematicBody2D

var velocity
var speed = 500
const EXPLOSION = preload("res://Objects/objExplosion.tscn")

func _physics_process(delta):
	position += velocity/3

func _on_Area2D_body_entered(body):
	var explosion = EXPLOSION.instance()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	$"/root/Hub/Player/RPGFire".stop()
	queue_free()
