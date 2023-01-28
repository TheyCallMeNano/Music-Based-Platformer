extends Node

var equipped = [0,0,0]
var levelComplete = false
var speedTally = 0
var score = 100000
var grappleBought = false

func _process(_delta):
	score = int(round(score))
