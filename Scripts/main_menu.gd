extends Control
var dataFromFile = {}
var newResolution
var newMode
var attempts = 0
@onready var txtFile = './Data/configs/config.json'

func _ready() -> void:
	
	var file = FileAccess.open(txtFile, FileAccess.READ)
	var dataFromFile = JSON.parse_string(file.get_as_text())
	
	# To make sure it actually detects something smh || Fix later
	if dataFromFile.size() < 6:
		Global.write("screenX", 1280, txtFile)
		Global.write("screenY", 720, txtFile)
		Global.write("buttonNo", 2, txtFile)
		Global.write("borderless", false, txtFile)
		Global.write("currentScreen", 0, txtFile)
		Global.write("mode", "windowed", txtFile)
		Global.write("modeNo", 1, txtFile)
		dataFromFile = JSON.parse_string(file.get_as_text())
		
	# Sets current screen and size
	get_tree().root.unresizable = true
	get_tree().root.position = Vector2i(50,100)
	
	DisplayServer.window_set_size(Vector2i(dataFromFile["screenX"],dataFromFile["screenY"]))
	get_tree().root.content_scale_size = Vector2i(dataFromFile["screenX"],dataFromFile["screenY"])

	if dataFromFile["mode"] == "windowed":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		get_tree().root.borderless = false
	if dataFromFile["mode"] == "fullscreen":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if dataFromFile["mode"] == "windowed-borderless":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		get_tree().root.borderless = true
	
	# Sets up the options button to be accurate to current screen
	$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.selected = int(dataFromFile["buttonNo"])
	$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/WindowControls/OptionButton.selected = int(dataFromFile["modeNo"])
# This function
func _on_settings_pressed() -> void:
	$SettingsControls.visible = !$SettingsControls.visible
	$Menu.visible = !$Menu.visible

func _setSize(this) -> void:
	# [2560 x 1440], [1920 x 1080], [1280 x 720], [640, 480]
	#xResolution, yResolution, OptionButton_Selected
	match (this):
		0:
			newResolution = [2560,1440,0]
		1:
			newResolution = [1920,1080,1]
		2:
			newResolution = [1280,720,2]
		3:
			newResolution = [640,480,3]

func _setMode(this) -> void:
	match (this):
		0:
			newMode = ["fullscreen", 0]
		1:
			newMode = ["windowed", 1]
		2:
			newMode = ["windowed-borderless", 2]

func _quit_window() -> void:
	get_tree().quit()

func _restart_window() -> void:
	if newResolution != null:
		Global.write("screenX", newResolution[0], txtFile)
		Global.write("screenY", newResolution[1], txtFile)
		Global.write("buttonNo", newResolution[2], txtFile)
	if newMode != null:
		Global.write("mode", newMode[0], txtFile)
		Global.write("modeNo", newMode[1], txtFile)
	get_tree().quit()
