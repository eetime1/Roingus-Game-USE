extends Node2D

@export var level = 1

func _ready():
	#Global.write("currentScreen", DisplayServer.window_get_current_screen())
	AudioManager.play("Game")
	Global.data["gemCount"] = 100
	Global.data["health"] = 200
	Global.data["roingusCount"] = 0
