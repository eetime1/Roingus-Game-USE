extends CharacterBody2D

@onready var timer = 0
var turretHealth = 200
var changeDet = 200
var distFromHome = 0
var bakeTimer = 0

func _ready():
	add_to_group("navigation")
	add_to_group("mycelium")
	pass

func _physics_process(delta: float) -> void:
	
	if changeDet != turretHealth:
		changeDet = turretHealth
		Global.data["health"] = changeDet
	timer += delta
	
	if changeDet <= 0 || Global.data["gemCount"] <= 0:
		print("game over goes here. this msg is in HomeShroom.gd")
	
	if timer >= 1:
		timer -= 1
		Global.data["gemCount"] -= 1

	
