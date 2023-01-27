#This is essentially what we are modifiying
extends KinematicBody2D

const speed = 800
const jump = -200
const grav = 8
const accl = 50

const UP = Vector2(0,-1)

var motion = Vector2()

func _physics_process(delta):
	motion.y += grav
	
	if Input.is_action_pressed("moveRight"):
		motion.x = min(motion.x+accl,speed)
	
	elif Input.is_action_pressed("moveLeft"):
		motion.x = max(motion.x-accl,-speed)
	
	else:
		motion.x = lerp(motion.x,0,0.2)
		
	if is_on_floor():
		if Input.is_action_just_pressed("moveUp"):
			motion.y = jump
	elif !is_on_floor():
		if Input.is_action_just_pressed("moveDown"):
			motion.y = -jump
		
	motion = move_and_slide(motion,UP)

func _process(delta):
	if Input.is_action_just_pressed("slot1"):
		global.equipped = [1,0,0]
	if Input.is_action_just_pressed("slot2"):
		global.equipped = [0,1,0]
	if Input.is_action_just_pressed("slot3"):
		global.equipped = [0,0,1]
