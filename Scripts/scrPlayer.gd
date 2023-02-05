#This is essentially what we are modifiying
extends KinematicBody2D

export(PackedScene) var footStep
export var RANDOMSHAKE: float = 30
export var SHAKEDECAY: float = 5
export var SHAKESPEED: float = 30
export var SHAKESTRENGTH: float = 5

export var speed = 800
export var jump = -375
const grav = 18
const accl = 50

onready var rand = RandomNumberGenerator.new()
onready var noise = OpenSimplexNoise.new()

var noiseI: float = 0
var shakeStrength: float = 0
var lastStep = 0

const UP = Vector2(0,-1)

var motion = Vector2()
var jumpsLeft = 2

var hookPos = Vector2()
var hooked = false
var ropeLength = 500
var currentRopeLength

var isDead = false

const ROCKET = preload("res://Objects/objRocket.tscn")

onready var animationPlayer = get_node("AnimationPlayer")

func _ready():
	currentRopeLength = ropeLength
	rand.randomize()
	noise.seed = rand.randi()
	noise.period = 2
	$ShopPiano.play()
	
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
	
	if Input.is_action_pressed("moveRight") && isDead == false:
		motion.x = min(motion.x+accl,speed+global.speedMultiplier)
		if is_on_floor():
			animationPlayer.play("Run")
			get_node("Sprite").set_flip_h(false)
	
	elif Input.is_action_pressed("moveLeft") && isDead == false:
		motion.x = max(motion.x-accl,-speed+-global.speedMultiplier)
		if is_on_floor():
			animationPlayer.play("Run")
			get_node("Sprite").set_flip_h(true)
	
	else:
		if isDead == false:
			motion.x = lerp(motion.x,0,0.2)
			if is_on_floor():
				animationPlayer.play("Idle")
		
	if jumpsLeft != 0 && isDead == false:
		if Input.is_action_just_pressed("moveUp"):
			if global.jumpMultiplier > 1:
				jump *= global.jumpMultiplier
			motion.y = jump
			jumpsLeft -= 1
			jump = -375
	if !is_on_floor() && !isDead:
		animationPlayer.play("InAir")
		if Input.is_action_just_pressed("moveDown") && isDead == false:
			motion.y = -jump
	if is_on_floor():
		jumpsLeft = 1
		

	if Input.is_action_just_pressed("moveRight") && is_on_floor() && isDead == false:
		$Footsteps.play()
	
	elif Input.is_action_just_pressed("moveLeft") && is_on_floor() && isDead == false:
		$Footsteps.play()
	
	elif Input.is_action_just_released("moveRight") || Input.is_action_just_released("moveLeft") || !is_on_floor():
		$Footsteps.stop()

	motion = move_and_slide(motion,UP)
	
	if global.equipped == [0,0,1] && global.slot3 == 1:
		$sprBoomboxGun.visible = true
		hook()

	elif global.equipped == [0,1,0] && global.slot2 == 1:
		$sprBoomboxGun.visible = true
		rocket()
	
	elif global.equipped == [0,0,0]:
		$sprBoomboxGun.visible = false
	
	spawnParticle()
	
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
		pass

func _process(delta):
	if Input.is_action_just_pressed("slot2"):
		if global.rpgBought == true:
			global.equipped = [0,1,0]
			$ShakeController.play("RPGShake")
			$MusicPlayer.play("FadeToRPG")
			$RPGRock.play()
	if Input.is_action_just_pressed("slot3"):
		if global.grappleBought == true:
			global.equipped = [0,0,1]
			$MusicPlayer.play("FadeToGrapple")
			$ShakeController.stop()
			$GrappleFunk.play()
		
	shakeStrength = lerp(shakeStrength, 0, SHAKEDECAY * delta)
	$Camera2D.offset = getRandomOffset()
		
	if Input.is_action_just_pressed("resetLevel"):
		position = Vector2(-128,-128)
		motion = Vector2(0,0)
		global.levelComplete = false
		global.levelStart = false
		isDead = false
		global.taxes += global.credits/2
		global.credits = global.credits/2
		if global.jumpMultiplier != 1:
			global.jumpMultiplier -= 0.5
		if global.speedMultiplier > 0:
			global.speedMultiplier -= 100
		global.deaths += 1
		$sprBoomboxGun.visible = true
		$DeathText.visible_characters = 0
		$Respawn.visible_characters = 0
		$BlackBar.modulate = Color(0,0,0,0)
		$ShopPiano.play()
		$UnarmedJive.stop()

func spawnParticle():
	if motion.x == 0:
		lastStep = -1
	if $AnimationPlayer.current_animation == "Run":
		if lastStep != $Sprite.frame:
			lastStep = $Sprite.frame
			var fs = footStep.instance()
			fs.emitting = true
			fs.global_position = Vector2(global_position.x,global_position.y+12)
			get_parent().add_child(fs)

func gameOver():
	if isDead == false:
		isDead = true
		animationPlayer.play("Death")
		$sprBoomboxGun.visible = false

func hook():
	$sprBoomboxGun/Raycast.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("primaryFire") && isDead == false:
		hookPos = getHookPos()
		if hookPos:
			hooked = true
			currentRopeLength = global_position.distance_to(hookPos)
			$GrappleConnect.play()
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
	if Input.is_action_just_pressed("primaryFire") && isDead == false:
		$RPGFire.play()
		var rocket = ROCKET.instance()
		rocket.rotation = $sprBoomboxGun.rotation
		rocket.position = $sprBoomboxGun.global_position
		rocket.velocity = Vector2(get_global_mouse_position() - rocket.position)
		get_parent().add_child(rocket)
