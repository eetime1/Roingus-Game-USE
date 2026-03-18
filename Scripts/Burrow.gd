extends Node2D

var civSaved = 0
@export var civInside = 3

func _physics_process(delta: float) -> void:
	if civSaved >= civInside:
		$BurrowSaved.visible = true
		$BurrowSOS.visible = false
	else:
		$BurrowSaved.visible = false
		$BurrowSOS.visible = true
