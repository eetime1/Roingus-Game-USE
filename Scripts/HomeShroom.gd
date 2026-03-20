extends CharacterBody2D

@onready var timer = 0
var turretHealth = 200
var changeDet = 200
var distFromHome = 0
var bakeTimer = 0

func _ready():
	add_to_group("navigation")
	add_to_group("mycelium")
	turretHealth = Global.data['health']
	changeDet = turretHealth
	$ProgressBar.max_value = turretHealth
	$ProgressBar.value = turretHealth
	pass

func _physics_process(delta: float) -> void:
	
	if changeDet != turretHealth:
		changeDet = turretHealth
		Global.data["health"] = changeDet
		$ProgressBar.value = turretHealth
	timer += delta
	
	if changeDet <= 0 || Global.data["gemCount"] <= 0:
		print("game over goes here. this msg is in HomeShroom.gd")
		get_tree().change_scene_to_file("res://Scenes/Levels/game_over.tscn")
	
	if timer >= 1:
		timer -= 1
		Global.data["gemCount"] += 10
