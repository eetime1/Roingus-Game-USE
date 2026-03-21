extends Control

func ready():
	#Transition.goaway()
	pass
	

func _on_button_button_down() -> void:
	#Transition.dothething()
	#await Transition.came
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")
	pass # Replace with function body.
