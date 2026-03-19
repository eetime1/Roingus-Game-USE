extends Node2D
#var camEdgesX = [-9999999, 9999999]
#var camEdgesY = [-9999999, 9999999]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RoingusUnit/Sprite2DEmpty.skewIncrem = 0.003
	$Player.camEdgesX = [-5458, 9072]
	$Player.camEdgesY = [-3366, 4906]
