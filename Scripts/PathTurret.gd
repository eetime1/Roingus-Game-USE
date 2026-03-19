extends CharacterBody2D

var maxHealth = 50.0
var turretHealth = 50.0
var timer = 0

var distFromHome = 999999999
var lowerNodes = []
var isolated = false

func _ready():
	add_to_group("turrets")
	add_to_group('navigation')
	

func _process(delta: float) -> void:
	if turretHealth <= 0:
		queue_free()
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1:
		timer -= 1
		Global.data["gemCount"] -= 1


func _on_area_2d_area_entered(area: Area2D) -> void:
	var newDist = area.get_parent().distFromHome
	if newDist < distFromHome:
		distFromHome = newDist + 1
		lowerNodes.append(area.get_parent())
		isolated = false
	pass # Replace with function body.

func _on_area_2d_area_exited(area: Area2D) -> void:
	var lostDist = area.get_parent()
	if lostDist in lowerNodes:
		lowerNodes.erase(lostDist)
		if lowerNodes == []:
			isolated = true
		else:
			distFromHome = 999999999
			for i in range(lowerNodes.size()):
				if lowerNodes[i].distFromHome < distFromHome:
					distFromHome = lowerNodes[i].distFromHome + 1
	
