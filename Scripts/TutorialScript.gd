extends Node2D
#var camEdgesX = [-9999999, 9999999]
#var camEdgesY = [-9999999, 9999999]
var shroom
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RoingusUnit/Sprite2DEmpty.skewIncrem = 0.003
	$Player.camEdgesX = [-5458, 9072]
	$Player.camEdgesY = [-3366, 4906]
	Global.data["gemCount"] = 50000
	$GUI.turret_instantiate_tutorial.connect(instance)
	
func instance(mushroom = null) -> void:
	match (mushroom):
		"turret":
			shroom = load("res://Scenes/Characters/TurretPlain.tscn")
		"path":
			shroom = load("res://Scenes/Characters/Turretpath.tscn")
		"wall":
			shroom = load("res://Scenes/Characters/TurretWall.tscn")
		"heal":
			shroom = load("res://Scenes/Characters/TurretHeal.tscn")
		_:
			shroom = null
			
	if mushroom != null:
		Global.data["gemCount"] -= Global.mushroomsCost[mushroom]
		
	if shroom:
		var a = shroom.instantiate()
		add_child(a)
		a.position = Vector2(get_global_mouse_position() + Vector2(0, 640))
		print(a.position)
		
