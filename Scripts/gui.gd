extends Control

func _ready():
	pass
	
func _process(delta: float) -> void:
	$CanvasLayer/ProgressBar.value = int(Global.read("health"))
	$CanvasLayer/Crystals/Label2.text = str(Global.read("gemCount"))
	$CanvasLayer/Roingus/Label2.text = str(Global.read("roingusCount"))
	pass
	
func _quit_button():
	get_tree().quit()
	pass

func _open_build_menu():
	var positionChange = 460
	var positionMinimum = -100
	#print($CanvasLayer/BuildMenu.position.y - DisplayServer.window_get_size().y)
	if $CanvasLayer/BuildMenu.position.y - DisplayServer.window_get_size().y > positionMinimum:
		$CanvasLayer/BuildMenu.position.y -= positionChange
	else:
		$CanvasLayer/BuildMenu.position.y += positionChange
		
func _summoning_mushroom(extra_arg_0: int) -> void:
	match (extra_arg_0):
		0:
			print("Mushroom1")
		1:
			print("Mushroom2")
		2:
			print("Mushroom3")
	pass # Replace with function body.
