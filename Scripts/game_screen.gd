extends Node2D

var turret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GUI.turret_instantiate.connect(instance)
	pass # Replace with function body.
	
func instance(mushroom, mousePosition) -> void:
	match (mushroom):
		0:
			print("Mushroom1")
			turret = preload("res://Characters/TurretPlain.tscn")
		1:
			print("Mushroom2")
		2:
			print("Mushroom3")
			
	var a = turret.instantiate()
	add_child(a)
	var xPosition = $NavTest2/Player.position.x - (DisplayServer.window_get_size().x / 2) * (1/$NavTest2/Player/Camera2D.zoom.x) + mousePosition.x * (1/$NavTest2/Player/Camera2D.zoom.x)
	var yPosition = $NavTest2/Player.position.y - (DisplayServer.window_get_size().y / 2) * (1/$NavTest2/Player/Camera2D.zoom.y) + mousePosition.y * (1/$NavTest2/Player/Camera2D.zoom.y) + (640)
	# Theres a hardcoded section (meant to represent offsetY of the turretplain scene)
	a.position = Vector2(xPosition,yPosition)
