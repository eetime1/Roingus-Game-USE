extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("I'm tired")
	pass



func _on_button_pressed(shot) -> void:
	get_tree().change_scene_to_file("res://Scenes/Screen/game_screen.tscn")
	
	pass # Replace with function body.
