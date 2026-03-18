extends Node2D

var turret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GUI.turret_instantiate.connect(instance)
	pass # Replace with function body.
	
func instance(mushroom = null) -> void:
	match (mushroom):
		"turret":
			print('t0')
			turret = preload("res://Scenes/Characters/TurretPlain.tscn")
		1:
			print('t1')
			turret = null
		2:
			print('t2')
			turret = null
	if mushroom != null:
		var currentGems = int(Global.read("gemCount","./Data/GlobalData.json"))
		Global.write("gemCount", currentGems - Global.mushroomsCost[mushroom],"./Data/GlobalData.json")
		
	if turret:
		var a = turret.instantiate()
		$Level.add_child(a)
		a.position = Vector2(get_global_mouse_position() + Vector2(0, 640))
