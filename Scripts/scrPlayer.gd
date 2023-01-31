#This is essentially what we are modifiying
extends KinematicBody2D


const speed = 1600
const jump = -200
const grav = 12
const accl = 50

const UP = Vector2(0,-1)

var motion = Vector2()

var hookPos = Vector2()
var hooked = false
var ropeLength = 500
var currentRopeLength
onready var animationPlayer = get_node("AnimationPlayer")

func _ready():
	currentRopeLength = ropeLength
	
	
func _physics_process(delta):
	motion.y += grav
	
	if Input.is_action_pressed("moveRight"):
		motion.x = min(motion.x+accl,speed)
		animationPlayer.play("Run")
		get_node("Sprite").set_flip_h(false)
	
	elif Input.is_action_pressed("moveLeft"):
		motion.x = max(motion.x-accl,-speed)
		animationPlayer.play("Run")
		get_node("Sprite").set_flip_h(true)
	
	else:
		motion.x = lerp(motion.x,0,0.2)
		animationPlayer.play("Idle")
		
	if is_on_floor():
		if Input.is_action_just_pressed("moveUp"):
			motion.y = jump
	elif !is_on_floor():
		if Input.is_action_just_pressed("moveDown"):
			motion.y = -jump
		
	motion = move_and_slide(motion,UP)
	
	if global.equipped == [0,0,1]:
		hook()
	update()
	if hooked:
		motion.y += grav
		hookSwing(delta)
		#Swing Speed
		motion *= 0.9
		motion = move_and_slide(motion)

func _draw():
	#var pos = global_position
	if hooked:
		draw_line(Vector2(-2,-30), to_local(hookPos), Color(0, 1, 0), 3, true)
	else:
		return
		#var colliding = $Raycast.is_colliding()
		#var collidePoint = $Raycast.get_collision_point()
		#if colliding && pos.distance_to(collidePoint):
			#draw_line(Vector2(0,-1), to_local(collidePoint), Color(1,1,1), 0.5, true)

func _process(_delta):
	if Input.is_action_just_pressed("slot1"):
		global.equipped = [1,0,0]
	if Input.is_action_just_pressed("slot2"):
		global.equipped = [0,1,0]
	if Input.is_action_just_pressed("slot3"):
		if global.grappleBought == true:
			global.equipped = [0,0,1]

func hook():
	$sprBoomboxGun/Raycast.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("primaryFire"):
		hookPos = getHookPos()
		if hookPos:
			hooked = true
			currentRopeLength = global_position.distance_to(hookPos)
	if Input.is_action_just_released("primaryFire") && hooked:
		hooked = false

func getHookPos():
	for raycast in $sprBoomboxGun/Raycast.get_children():
		if raycast.is_colliding():
			return raycast.get_collision_point()

func hookSwing(delta):
	var radius = global_position - hookPos
	if motion.length() < 0.01 or radius.length() < 10:
		return
	var angle = acos(radius.dot(motion) / (radius.length() * motion.length()))
	var radVel = cos(angle) * motion.length()
	motion += radius.normalized() * -radVel
	
	if global_position.distance_to(hookPos) > currentRopeLength:
		global_position = hookPos + radius.normalized() * currentRopeLength
	
	motion += (hookPos - global_position).normalized() * 15000 * delta


func _on_Node2D_body_entered_(_body):
	global.speedTally = speed
