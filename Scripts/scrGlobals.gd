extends Node

var equipped = [0,0,0]
var slot1 = 0
var slot2 = 0
var slot3 = 0
var hotbar = [slot1,slot2,slot3]
var levelComplete = true
var levelStart = false
var speedTally = 0
var score = 100000
var jumpMultiplier = 1
var speedMultiplier = 0
var grappleBought = false
var rpgBought = false
var credits = 500000
var saveFile = "user://data.jjii"

func saveGame():
	var file = File.new()
	file.open(saveFile, File.WRITE)
	file.store_var(grappleBought)
	file.store_var(rpgBought)
	file.store_var(credits)
	file.store_var(speedMultiplier)
	file.store_var(jumpMultiplier)
	file.close()

func loadGame():
	var file = File.new()
	if file.file_exists(saveFile):
		file.open(saveFile, File.READ)
		#These vars MUST be in the same order they were saved in, otherwise you'll get the wrong value
		grappleBought = file.get_var()
		rpgBought = file.get_var()
		credits = file.get_var()
		speedMultiplier = file.get_var()
		jumpMultiplier = file.get_var()
		file.close()
	else:
		credits = 0
		grappleBought = false
		equipped = [0,0,0]
		rpgBought = false
		jumpMultiplier = 1
		speedMultiplier = 0

func _ready():
	loadGame()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		saveGame()

# warning-ignore:unused_argument
func _process(delta):
	if grappleBought == true:
		slot3 = 1
	if rpgBought == true:
		slot2 = 1
