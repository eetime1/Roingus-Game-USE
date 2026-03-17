extends Control

var isHoldingWhat = -1
signal turret_instantiate
	
func _process(_delta: float) -> void:
	$CanvasLayer/ProgressBar.value = int(Global.read("health"))
	$CanvasLayer/Crystals/Label2.text = str(Global.read("gemCount"))
	$CanvasLayer/Roingus/Label2.text = str(Global.read("roingusCount"))
	
	#var turrets = get_tree().get_nodes_in_group("turrets")
	
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && isHoldingWhat != -1:
			turret_instantiate.emit(isHoldingWhat, event.global_position)
			isHoldingWhat = -1
		
func _quit_button():
	get_tree().quit()

func _open_build_menu():
	var positionChange = 460
	var positionMinimum = -100
	#print($CanvasLayer/BuildMenu.position.y - DisplayServer.window_get_size().y)
	if $CanvasLayer/BuildMenu.position.y - DisplayServer.window_get_size().y > positionMinimum:
		$CanvasLayer/BuildMenu.position.y -= positionChange
	else:
		$CanvasLayer/BuildMenu.position.y += positionChange
		
func _summoning_mushroom(extra_arg_0: int) -> void:
	isHoldingWhat = extra_arg_0
