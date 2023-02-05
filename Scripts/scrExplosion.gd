extends Sprite

var repelForce = 1000
onready var animationPlayer = get_node("AnimationPlayer")
onready var mousePos = get_global_mouse_position()


func _ready():
	animationPlayer.play("Explosion")
	$AudioStreamPlayer2D.play()

func _on_Area2D_body_entered(body):
	if body == $"/root/Hub/Player":
		if mousePos.y > $"/root/Hub/Player".position.y:
			$"/root/Hub/Player".motion.y -= repelForce
		if mousePos.y < $"/root/Hub/Player".position.y:
			$"/root/Hub/Player".motion.y += repelForce
		if mousePos.x > $"/root/Hub/Player".position.x:
			$"/root/Hub/Player".motion.x -= repelForce
		if mousePos.x < $"/root/Hub/Player".position.x:
			$"/root/Hub/Player".motion.x += repelForce
	if body == $"/root/Hub/Glass":
		$"/root/Hub/Glass/Area2D/Breaking".emitting = true
		$"/root/Hub/Glass/Area2D/Breaking2".emitting = true
		$"/root/Hub/Glass/Area2D/Sprite".visible = false
		$"/root/Hub/Glass/Area2D/CollisionShape2D".disabled = true
		$"/root/Hub/Glass/PlayerCollide".queue_free()
