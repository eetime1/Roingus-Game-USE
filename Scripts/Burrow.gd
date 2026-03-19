extends Node2D

var civSaved = 0
@export var civInside = 3
var civGenned = 0
var isolated = true
var distFromHome = 999999999
var lowerNodes = []
var timer = 0

func _physics_process(delta: float) -> void:
	timer += delta
	
	#needs optimizing if you need something to do
	if civSaved >= civInside:
		$BurrowSaved.visible = true
		$BurrowSOS.visible = false
	else:
		$BurrowSaved.visible = false
		$BurrowSOS.visible = true
	
	if timer >= 5 && lowerNodes != [] && civGenned < civInside:
		timer -= 5
		var a = load("res://Scenes/Characters/RoingusCivilian.tscn").instantiate()
		get_parent().add_child(a)
		a.global_position = global_position
		a.burrow = self
		a.roingusHome.connect(savedFella)
		civGenned += 1
	elif timer >= 5:
		timer -=5
	

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
	

func savedFella() -> void:
	civSaved += 1
