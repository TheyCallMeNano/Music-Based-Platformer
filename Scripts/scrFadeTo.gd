extends Button

onready var transitionRect := $ColorRect

func _on_Button_pressed():
	transitionRect.transitionTo("res://Rooms/Hub.tscn")
