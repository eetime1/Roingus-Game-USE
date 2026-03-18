extends Control

var isHoldingWhat = null
signal turret_instantiate
	
func _process(_delta: float) -> void:
	$CanvasLayer/Health.value = Global.data["health"]
	$CanvasLayer/Crystals/Label2.text = str(Global.data["gemCount"])
	$CanvasLayer/Roingus/Label2.text = str(Global.data["roingusCount"])
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && isHoldingWhat != null:
			#if true: # event.x is NOT over non-allowed
			turret_instantiate.emit(isHoldingWhat)
			isHoldingWhat = null
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
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
	if int(Global.data["gemCount"]) > Global.mushroomsCost[extra_arg_0]:
		isHoldingWhat = extra_arg_0
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		print("broke")
