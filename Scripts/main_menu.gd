extends Control

func _ready() -> void:
	get_tree().root.content_scale_size.x = 1280
	get_tree().root.content_scale_size.y = 720
	pass

func _on_settings_pressed() -> void:
	$SettingsControls.visible = !$SettingsControls.visible
	$Menu.visible = !$Menu.visible
	#print(get_tree().root.content_scale_size) #1280 x 720

func _end_game() -> void:
	get_tree().quit()
	pass
