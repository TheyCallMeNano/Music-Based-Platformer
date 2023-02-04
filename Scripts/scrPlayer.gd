#This is essentially what we are modifiying
extends KinematicBody2D


export var RANDOMSHAKE: float = 30
export var SHAKEDECAY: float = 5
export var SHAKESPEED: float = 30
export var SHAKESTRENGTH: float = 5

var speed = 800
const jump = -200
const grav = 12
const accl = 50

onready var rand = RandomNumberGenerator.new()
onready var noise = OpenSimplexNoise.new()

var noiseI: float = 0
var shakeStrength: float = 0

const UP = Vector2(0,-1)

var motion = Vector2()
var jumpsLeft = 2

var hookPos = Vector2()
var hooked = false
var ropeLength = 500
var currentRopeLength



const ROCKET = preload("res://Objects/objRocket.tscn")

onready var animationPlayer = get_node("AnimationPlayer")

func _ready():
	currentRopeLength = ropeLength
	rand.randomize()
	noise.seed = rand.randi()
	noise.period = 2
	$UnarmedJive.play()
	
func shake() -> void:
	shakeStrength = SHAKESTRENGTH


func getNoiseOffset(delta: float) -> Vector2:
	noiseI += delta * SHAKESPEED
	
	return Vector2(
		noise.get_noise_2d(1, noiseI) * shakeStrength,
		noise.get_noise_2d(100,noiseI) * shakeStrength
	)

func getRandomOffset() -> Vector2:
	return Vector2(
		rand.randf_range(-shakeStrength, shakeStrength),
		rand.randf_range(-shakeStrength, shakeStrength)
	)

func _physics_process(delta):
	motion.y += grav
	
	if Input.is_action_pressed("moveRight"):
		motion.x = min(motion.x+accl,speed)
		if is_on_floor():
			animationPlayer.play("Run")
			get_node("Sprite").set_flip_h(false)
	
	elif Input.is_action_pressed("moveLeft"):
		motion.x = max(motion.x-accl,-speed)
		if is_on_floor():
			animationPlayer.play("Run")
			get_node("Sprite").set_flip_h(true)
	
	else:
		motion.x = lerp(motion.x,0,0.2)
		if is_on_floor():
			animationPlayer.play("Idle")
		
	if jumpsLeft != 0:
		if Input.is_action_just_pressed("moveUp"):
			motion.y = jump
			jumpsLeft -= 1
	if !is_on_floor():
		animationPlayer.play("InAir")
		if Input.is_action_just_pressed("moveDown"):
			motion.y = -jump
	if is_on_floor():
		jumpsLeft = 1
		

	if Input.is_action_just_pressed("moveRight") && is_on_floor():
		$Footsteps.play()
	
	elif Input.is_action_just_pressed("moveLeft") && is_on_floor():
		$Footsteps.play()
	
	elif Input.is_action_just_released("moveRight") || Input.is_action_just_released("moveLeft"):
		$Footsteps.stop()

	motion = move_and_slide(motion,UP)
	
	if global.equipped == [0,0,1] && global.slot3 == 1:
		hook()

	elif global.equipped == [0,1,0] && global.slot2 == 1:
		rocket()

	elif global.equipped == [1,0,0] && global.slot1 == 1:
		pass
	update()
	if hooked:
		motion.y += grav
		hookSwing(delta)
		#Swing Speed
		motion *= 0.9
		motion = move_and_slide(motion)

func _draw():
	if hooked:
		draw_line(Vector2(-2,-30), to_local(hookPos), Color(0, 1, 0), 3, true)
	else:
		$GrappleConnect.play()

func _process(delta):
	if Input.is_action_just_pressed("slot1"):
		global.equipped = [1,0,0]
	if Input.is_action_just_pressed("slot2"):
		$ShakeController.play("RPGShake")
		$MusicPlayer.play("FadeToRPG")
		$RPGRock.play()
		if global.rpgBought == true:
			global.equipped = [0,1,0]
	if Input.is_action_just_pressed("slot3"):
		$MusicPlayer.play("FadeToGrapple")
		$ShakeController.stop()
		$GrappleFunk.play()
		if global.grappleBought == true:
			global.equipped = [0,0,1]
		
	shakeStrength = lerp(shakeStrength, 0, SHAKEDECAY * delta)
	$Camera2D.offset = getRandomOffset()
		
	if Input.is_action_just_pressed("resetLevel"):
		position = Vector2(-128,-128)
		motion = Vector2(0,0)
		global.levelComplete = false

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

func rocket():
	if Input.is_action_just_pressed("primaryFire"):
		$RPGFire.play()
		var rocket = ROCKET.instance()
		rocket.rotation = $sprBoomboxGun.rotation
		rocket.position = $sprBoomboxGun.global_position
		rocket.velocity = Vector2(get_global_mouse_position() - rocket.position)
		get_parent().add_child(rocket)
