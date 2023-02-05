extends Button

onready var transitionRect := $ColorRect

func _on_Play_pressed():
	transitionRect.transitionTo("res://Rooms/Hub.tscn")
