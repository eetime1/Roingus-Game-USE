extends Control

func _ready():
	Transition.came

func _on_try_again_pressed() -> void:
	Transition.dothething()
	await Transition.came
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")
	#match (Global.currentLevel):
		#0:
			#get_tree().change_scene_to_file("res://Scenes/Levels/level1.tscn")
		#1:
			#get_tree().change_scene_to_file("res://Scenes/Levels/level2.tscn")
		#2:
			#get_tree().change_scene_to_file("res://Scenes/Levels/level3.tscn")
