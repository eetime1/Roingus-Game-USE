extends Control

var isHoldingWhat = null
signal turret_instantiate

func _process(_delta: float) -> void:
	$CanvasLayer/ProgressBar.value = int(Global.read("health"))
	$CanvasLayer/Crystals/Label2.text = str(Global.read("gemCount"))
	$CanvasLayer/Roingus/Label2.text = str(Global.read("roingusCount"))
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && isHoldingWhat != null:
			turret_instantiate.emit(isHoldingWhat)
			isHoldingWhat = null
		
func _quit_button():
	get_tree().quit()

func _open_build_menu():
	var positionChange = 350
	var positionMinimum = -100
	if $CanvasLayer/BuildMenu.position.y - DisplayServer.window_get_size().y > positionMinimum:
		$CanvasLayer/BuildMenu.position.y -= positionChange
	else:
		$CanvasLayer/BuildMenu.position.y += positionChange
		
func _summoning_mushroom(extra_arg_0: String) -> void:
	if int(Global.read("gemCount","./Data/GlobalData.json")) > Global.mushroomsCost[extra_arg_0]:
		isHoldingWhat = extra_arg_0
	else:
		print("broke")
