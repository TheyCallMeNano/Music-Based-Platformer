extends Sprite

var repelForce = 1000
onready var animationPlayer = get_node("AnimationPlayer")
onready var mousePos = get_global_mouse_position()


func _ready():
	animationPlayer.play("Explosion")
	$AudioStreamPlayer2D.play()
	



func _on_Area2D_body_entered(body):
	print("mousePos: "+ str(mousePos))
	if body == $"/root/Hub/Player":
		if mousePos.y > $"/root/Hub/Player".position.y:
			$"/root/Hub/Player".motion.y -= repelForce
			print($"/root/Hub/Player".position)
		if mousePos.y < $"/root/Hub/Player".position.y:
			$"/root/Hub/Player".motion.y += repelForce
			print($"/root/Hub/Player".position)
		if mousePos.x > $"/root/Hub/Player".position.x:
			$"/root/Hub/Player".motion.x -= repelForce
			print($"/root/Hub/Player".position)
		if mousePos.x < $"/root/Hub/Player".position.x:
			$"/root/Hub/Player".motion.x += repelForce
			print($"/root/Hub/Player".position)
		
