extends CharacterBody2D

@onready var timer = 0
var turretHealth = 100

func _physics_process(delta: float) -> void:
	Global.write("health", turretHealth)
	timer += delta
	
	if int(Global.read("health")) <= 0 || int(Global.read("gemCount")) <= 0:
		print("game over goes here. this msg is in HomeShroom.gd")
	
	if timer >= 1:
		timer -= 1
		var crystals = Global.read("gemCount")
		Global.write("gemCount", int(crystals)-1)
	
