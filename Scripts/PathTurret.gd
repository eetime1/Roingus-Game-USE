extends CharacterBody2D

var maxHealth = 50.0
var turretHealth = 50.0
var timer = 0
var bakeTimer = 0

var distFromHome = 999999999
var lowerNodes = []
var isolated = false

func _ready():
	add_to_group("turrets")
	add_to_group("mycelium")
	add_to_group('navigation')
	$NavMycelium.bake_navigation_polygon()

func _process(delta: float) -> void:
	bakeTimer += delta
	if bakeTimer >= 0.5:
		bakeTimer -= 0.5
		$StaticMycelium/CollisionShape2D.disabled = true
		$NavMycelium.bake_navigation_polygon()
		$StaticMycelium/CollisionShape2D.disabled = false
	
	if turretHealth <= 0:
		#$"../NavigationRegion2DCIV".NavigationMeshSourceGeometryData2D.clear()
		#remove_from_group("mycelium")
		#var mycelials = get_parent().get_nodes_in_group("mycelium")
		#for i in range(mycelials.size()):
		#	$"../NavigationRegion2DCIV".NavigationMeshSourceGeometryData2D.merge(mycelials[i].NavMycelium.NavigationMeshSourceGeometryData2D)
		
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
			distFromHome = 999999999
		else:
			distFromHome = 999999999
			for i in range(lowerNodes.size()):
				if lowerNodes[i].distFromHome < distFromHome:
					distFromHome = lowerNodes[i].distFromHome + 1
	

func returnNextNode() -> Node:
	var nextNode = lowerNodes[0]
	for i in range(lowerNodes.size()):
		if lowerNodes[i].distFromHome < nextNode.distFromHome:
			nextNode = lowerNodes[i]
	return nextNode
