extends Label


func _ready():
	text = "Congratulations! You beat the game; here's a quick overview of your ability. You paid " + str(global.taxes) + " in taxes. You also payed the price " + str(global.deaths) + " times. Overall, you paid " + str(global.timePassed) +  " playing the game."
