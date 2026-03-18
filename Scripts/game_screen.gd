extends Node2D

var shroom

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GUI.turret_instantiate.connect(instance)
	pass # Replace with function body.
	
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
		$Level.add_child(a)
		a.position = Vector2(get_global_mouse_position() + Vector2(0, 640))
		print(a.position)
		
