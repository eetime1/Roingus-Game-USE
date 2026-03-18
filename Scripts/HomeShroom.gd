extends CharacterBody2D

@onready var timer = 0

func _physics_process(delta: float) -> void:
	timer += delta
	if timer >= 1:
		timer -= 1
		var crystals = Global.read("gemCount")
		Global.write("gemCount", int(crystals)-1)
	
