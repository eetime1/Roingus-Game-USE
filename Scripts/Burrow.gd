extends Node2D

var isSaved = false
var civSaved = 0

func _physics_process(delta: float) -> void:
	if isSaved:
		$BurrowSaved.visible = true
		$BurrowSOS.visible = false
	else:
		$BurrowSaved.visible = false
		$BurrowSOS.visible = true
