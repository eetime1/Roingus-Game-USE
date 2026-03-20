extends Control
var dataFromFile = {}
var newResolution
var newMode
var incrWindow = Vector2(5, 20)
@onready var txtFile = './Data/configs/config.json'
@export var squeak: AudioStream

# This one should check for if anything thats calling it has audiostreamplayer
@onready var sound = $AudioStreamPlayer

func _ready() -> void:
	
	var file = FileAccess.open(txtFile, FileAccess.READ)
	dataFromFile = JSON.parse_string(file.get_as_text())
	get_tree().set_auto_accept_quit(false)
	# To make sure it actually detects something smh || Fix later
	if dataFromFile.size() < 11:
		Global.write("screenX", 1280, txtFile)
		Global.write("screenY", 720, txtFile)
		Global.write("screenButtonNo", 2, txtFile)
		Global.write("borderless", false, txtFile)
		Global.write("currentScreen", 0, txtFile)
		Global.write("mode", "windowed", txtFile)
		Global.write("modeNo", 1, txtFile)
		Global.write("showFPS", false, txtFile)
		Global.write("noMycelium", false, txtFile)
		Global.write("squeak", true, txtFile)
		Global.write("level", 0, txtFile)
		dataFromFile = JSON.parse_string(file.get_as_text())
		
	# Sets current screen and size
	DisplayServer.window_set_size(Vector2i(dataFromFile["screenX"], dataFromFile["screenY"]))
	get_tree().root.content_scale_size = Vector2i(dataFromFile["screenX"],dataFromFile["screenY"])
	DisplayServer.window_set_current_screen(dataFromFile["currentScreen"])
	get_tree().root.unresizable = true
	
	if dataFromFile["mode"] == "windowed":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		get_tree().root.borderless = false
	elif dataFromFile["mode"] == "fullscreen":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif dataFromFile["mode"] == "windowed-borderless":
		incrWindow = Vector2(0,0)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		get_tree().root.borderless = true
		
	var centerPositioningX = DisplayServer.screen_get_position().x + incrWindow.x + (DisplayServer.screen_get_size().x / 2.0 - DisplayServer.window_get_size().x / 2.0)
	var centerPositioningY = DisplayServer.screen_get_position().y + incrWindow.y + (DisplayServer.screen_get_size().y / 2.0 - DisplayServer.window_get_size().y / 2.0)
	get_tree().root.position = Vector2i(centerPositioningX, centerPositioningY)
	
	# Sets up the options button to be accurate to current screen
	
	if name == "MainMenu":
		if DisplayServer.window_get_mode() == 3:
			$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.disabled = true
		else:
			$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.disabled = false
		
		AudioManager.play("Menus")
		$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.selected = int(dataFromFile["screenButtonNo"])
		$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/WindowControls/OptionButton.selected = int(dataFromFile["modeNo"])
		$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ShowFps/CheckButton.button_pressed = bool(dataFromFile["showFPS"])
		$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/NoMycelium/CheckButton.button_pressed = bool(dataFromFile["noMycelium"])
		$SettingsControls/SettingsTabs/Audio/MarginContainer/VAudio/HBoxContainer/CheckButton.button_pressed = bool(dataFromFile["squeak"])

	elif name == "InGameSettings":
		$CanvasLayer/CenterContainer/Panel/VBoxContainer/DisplayMode/Panel/WindowControls/OptionButton.selected = int(dataFromFile["modeNo"])
		$CanvasLayer/CenterContainer/Panel/VBoxContainer/DisplayResolution/Panel/ScreenSize/OptionButton.selected = int(dataFromFile["screenButtonNo"])



func _on_settings_pressed() -> void:
	if name == "MainMenu":
		$SettingsControls.visible = !$SettingsControls.visible
		$Menu.visible = !$Menu.visible
	elif name == "InGameSettings":
		$CanvasLayer.visible = !$CanvasLayer.visible
	_restart_global()

func _setSize(this) -> void:
	# [2560 x 1440], [1920 x 1080], [1280 x 720], [640, 360]
	#xResolution, yResolution, OptionButton_Selected
	match (this):
		0:
			newResolution = [2560,1440,0]
		1:
			newResolution = [1920,1080,1]
		2:
			newResolution = [1280,720,2]
		3:
			newResolution = [640,360,3]

	get_tree().root.content_scale_size = Vector2i(newResolution[0],newResolution[1])
	DisplayServer.window_set_size(get_tree().root.content_scale_size)
	_restart_global()
	
func _setMode(this) -> void:
	match (this):
		0:
			newMode = ["fullscreen", 0]
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			if name == "MainMenu":
				$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.disabled = true
			get_tree().root.borderless = false
		1:
			newMode = ["windowed", 1]
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			if name == "MainMenu":
				$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.disabled = false
			get_tree().root.borderless = false
		2:
			newMode = ["windowed-borderless", 2]
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			if name == "MainMenu":
				$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.disabled = false
			get_tree().root.borderless = true
			

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("setting"):
		if name == "MainMenu":
			$SettingsControls.visible = !$SettingsControls.visible
			$Menu.visible = !$Menu.visible
		elif name == "InGameSettings":
			$CanvasLayer.visible = !$CanvasLayer.visible

func _quit_window() -> void:
	get_tree().quit()

func _open_scene():
	soundy()
	get_tree().change_scene_to_file("res://Scenes/Levels/WorldMap.tscn")
	# Use threading https://docs.godotengine.org/en/stable/tutorials/performance/using_multiple_threads.html

func soundy():
	AudioManager.play_audio_oneshot(squeak)
	

func _open_tutorial():
	get_tree().change_scene_to_file("res://Scenes/Levels/TutorialGame.tscn")
	
func _restart_global() -> void:
	if newResolution != null:
		Global.write("screenX", newResolution[0], txtFile)
		Global.write("screenY", newResolution[1], txtFile)
		Global.write("screenButtonNo", newResolution[2], txtFile)
	if newMode != null:
		Global.write("mode", newMode[0], txtFile)
		Global.write("modeNo", newMode[1], txtFile)
	prints(dataFromFile["screenX"],dataFromFile["screenY"],DisplayServer.window_get_size(),get_tree().root.content_scale_size,DisplayServer.window_get_mode())


func _toggles(toggled_on: bool, what = "string") -> void:
	if toggled_on == true:
		Global.write(what, true, txtFile)
	elif toggled_on == false:
		Global.write(what, false, txtFile)

func _igSToggle():
	pass

func _returnToMenu():
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")

func _extras() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Extras.tscn")
	
	


func _on_credits_button_down() -> void:
	$Image2.visible = !$Image2.visible
	
	
	pass # Replace with function body.
