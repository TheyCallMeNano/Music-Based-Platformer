extends Area2D

var frozen = false
var time = 0

func _process(delta):
	if frozen == true:
		time += delta
		$"..".speed = 1200
	if time >= 1.5:
		$"..".speed = 800
		frozen = false
		time = 0
		print($"..".speed)


func _on_FrozenGround_area_entered(area):
	if area == $"../sprBoomboxGun/IceGun":
		frozen = true
