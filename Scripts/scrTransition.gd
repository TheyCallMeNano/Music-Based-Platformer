extends ColorRect

# Path to the next scene to transition to
export(String, FILE, "*.tscn") var nextScenePath

# Reference to the _AnimationPlayer_ node
onready var animPlayer := $AnimationPlayer

func _ready() -> void:
	animPlayer.play_backwards("Transition")


func transitionTo(nextScene := nextScenePath) -> void:
	animPlayer.play("Transition")
	yield(animPlayer, "animation_finished")
	get_tree().change_scene(nextScene)
