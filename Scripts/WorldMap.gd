extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect/Button2.disabled = true
	$TextureRect/Button3.disabled = true
	var lvl = Global.read("level")

	if lvl == 0:
		$TextureRect.texture = load("res://Assets/Backgrounds/MapLevel1.png")
		$TextureRect/Button2.disabled = true
		$TextureRect/Button3.disabled = true
	elif lvl == 1:
		$TextureRect.texture = load("res://Assets/Backgrounds/MapLevel2.png")
		$TextureRect/Button2.disabled = false
		$TextureRect/Button3.disabled = true
	elif lvl == 2:
		$TextureRect.texture = load("res://Assets/Backgrounds/MapLevel3.png")
		$TextureRect/Button2.disabled = false
		$TextureRect/Button3.disabled = false



func _quit_button():
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")

func _on_button_pressed(_shot, level) -> void:
	match(level):
		0:
			get_tree().change_scene_to_file("res://Scenes/Screen/L1.tscn")
		1:
			get_tree().change_scene_to_file("res://Scenes/Screen/L2.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Screen/L3.tscn")
		_:
			pass
	
	
	pass # Replace with function body.
