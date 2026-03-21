extends Control

func _ready():
	Transition.goaway()

func _on_return_pressed() -> void:
	Transition.dothething()
	await Transition.came
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")
