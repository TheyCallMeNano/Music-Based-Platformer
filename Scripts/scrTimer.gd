extends Label


var time = 0
var minsStore = 0
var secsStore = 0

func _process(delta):
	if global.levelComplete == false:
		time += delta
		var mils = fmod(time,1)*1000
		var secs = fmod(time,60)
		var mins = fmod(time,60*60) / 60
		minsStore = mins
		secsStore = secs
		var timePassed = "%02d : %02d : %03d" % [mins,secs,mils]
		text = timePassed
		global.speedTally = $"/root/Hub/Player".speed
		global.score -= minsStore+secsStore*100/global.speedTally
	else:
		time = 0
		
	if Input.is_action_pressed("resetLevel"):
		time = 0
		global.levelComplete = true
		global.levelStart = false
