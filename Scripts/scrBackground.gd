extends Sprite

func _process(delta):
	if global.equipped == [1,0,0]:
		texture = load("res://Sprites/sprfinalDay.png")
	if global.equipped == [0,1,0]:
		texture = load("res://Sprites/sprGlacialMountains.png")
	if global.equipped == [0,0,1]:
		texture = load("res://Sprites/sprSpaceBackground.png")
