extends Label


func _process(_delta):
		text = ("Credits: " + str(global.credits) + "\nScore: " + str(global.score))
