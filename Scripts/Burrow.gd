extends Node2D

var civSaved = 0
@export var civInside = 3
var civGenned = 0
var isolated = true
var distFromHome = 9999999999
	
var lowerNodes = []
var timer = 0

func _physics_process(delta: float) -> void:
	timer += delta
	
	
	if timer >= 5 && lowerNodes != [] && civGenned < civInside:
		timer -= 5
		var a = load("res://Scenes/Characters/RoingusCivilian.tscn").instantiate()
		a.global_position = global_position
		a.burrow = self
		get_parent().add_child(a)
		a.roingusHome.connect(savedFella)
		civGenned += 1
	elif timer >= 5:
		timer -=5
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	var newDist = area.get_parent().distFromHome
	if newDist < distFromHome:
		distFromHome = newDist + 1
		print('added')
		lowerNodes.append(area.get_parent())
		print(self)
		print(lowerNodes)
		isolated = false
	pass # Replace with function body.

func _on_area_2d_area_exited(area: Area2D) -> void:
	print('rm')
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
	if civSaved >= civInside:
		$BurrowSaved.visible = true
		$BurrowSOS.visible = false
		var a = load("res://Scenes/Characters/RoingusUnit.tscn").instantiate()
		a.global_position = $"../HomeShroom".global_position
		a.burrow = self
		get_parent().add_child(a)
	
