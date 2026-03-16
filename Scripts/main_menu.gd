extends Control
var dataFromFile
var attempts = 0
@onready var txtFile = './configs/config.txt'

func _ready() -> void:
	
	var file = FileAccess.open(txtFile, FileAccess.READ)
	var dataFromFile = JSON.parse_string(file.get_as_text())
	
	# To make sure it actually detects something smh || Fix later
	if dataFromFile.size() < 3:
		dataFromFile = ["1280","720","2"]
		
	# Sets current screen and size
	#DisplayServer.window_set_current_screen(1)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	#get_tree().root.unresizable = true
	#get_tree().root.borderless = false
	
	DisplayServer.window_set_size(Vector2i(int(dataFromFile[0]),int(dataFromFile[1])))
	get_tree().root.content_scale_size.x = int(dataFromFile[0])
	get_tree().root.content_scale_size.y = int(dataFromFile[1])

	# Sets up the options button to be accurate to current screen
	$SettingsControls/SettingsTabs/Video/MarginContainer/VVideo/ScreenSize/OptionButton.selected = int(dataFromFile[2])

# This function
func _on_settings_pressed() -> void:
	$SettingsControls.visible = !$SettingsControls.visible
	$Menu.visible = !$Menu.visible

func _setSize(this) -> void:
	# [2560 x 1440], [1920 x 1080], [1280 x 720], [640, 480]
	match (this):
		0:
			#xResolution, yResolution, OptionButton_Selected
			dataFromFile = ["2560","1440","0"]
		1:
			dataFromFile = ["1920","1080","1"]
		2:
			dataFromFile = ["1280","720","2"]
		3:
			dataFromFile = ["640","480","3"]

func _quit_window() -> void:
	get_tree().quit()

func _restart_window() -> void:
	var file = FileAccess.open(txtFile, FileAccess.WRITE)
	file.store_string(JSON.stringify(dataFromFile))
	get_tree().quit()
