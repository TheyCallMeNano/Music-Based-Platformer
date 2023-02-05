extends Button

onready var transitionRect := $ColorRect

func _on_Credits_pressed():
	transitionRect.transitionTo("res://Rooms/Credits.tscn")

