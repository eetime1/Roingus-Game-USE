extends Node2D

var turret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GUI.turret_instantiate.connect(instance)
	pass # Replace with function body.
	
func instance(mushroom) -> void:
	match (mushroom):
		0:
			#print("Mushroom1")
			turret = preload("res://Scenes/Characters/TurretPlain.tscn")
		1:
			#print("Mushroom2")
			turret = null
		2:
			#print("Mushroom3")
			turret = null
			
	if turret:
		var a = turret.instantiate()
		add_child(a)
		# Theres a hardcoded section (meant to represent offsetY of the turretplain scene)
		a.position = Vector2(get_global_mouse_position() + Vector2(0, 640))
