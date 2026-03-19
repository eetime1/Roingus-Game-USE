extends Control

var isHoldingWhat = null
signal turret_instantiate
signal changeHeld
var blockedNum = 0
var myceliumNum = 0

func _process(_delta: float) -> void:
	$CanvasLayer/Health.value = Global.data["health"]
	$CanvasLayer/Crystals/Label2.text = str(Global.data["gemCount"])
	$CanvasLayer/Roingus/Label2.text = str(Global.data["roingusCount"])
	
	$OnMouse.global_position = get_global_mouse_position()
	if $CanvasLayer/Panel2/Secret.modulate.a > 0.02:
		$CanvasLayer/Panel2/Secret.modulate.a = (1 -($CanvasLayer/AudioStreamPlayer2D.get_playback_position() / 1.25))
		$CanvasLayer/Panel2/Secret.self_modulate.a = (1 -($CanvasLayer/AudioStreamPlayer2D.get_playback_position() / 1.25))
	else:
		$CanvasLayer/Panel2/Secret.modulate.a = 0

	if Global.read("showFPS"):
		$CanvasLayer/FpsCounts.text = "FPS: " + str(Engine.get_frames_per_second())


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 2 && isHoldingWhat != null:
			isHoldingWhat = null
			emit_signal("changeHeld")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			print('cancelled')
		
		if event.button_index == 1 && isHoldingWhat != null && blockedNum == 0 && myceliumNum > 0:
			#if true: # event.x is NOT over non-allowed
			turret_instantiate.emit(isHoldingWhat)
			isHoldingWhat = null
			emit_signal("changeHeld")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif event.button_index == 1 && isHoldingWhat != null && blockedNum != 0:
			print('blocked')
		elif event.button_index == 1 && isHoldingWhat != null && myceliumNum == 0:
			
			
			if Global.read("noMycelium") == true:
				$CanvasLayer/AudioStreamPlayer2D.position = Global.globalPosition
				$CanvasLayer/AudioStreamPlayer2D.play()
				$CanvasLayer/Panel2/Secret.modulate.a = 1
				print('
---------------------------------------
⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
----------no mycelium???????----------')

			else:
				print("Not on mycelium")

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
		emit_signal("changeHeld")
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		print("broke")



func _on_on_mouse_body_entered(_body: Node2D) -> void:
	blockedNum += 1
	$OnMouse/Sprite2D.modulate = Color(255,0,0,0.5)
	pass # Replace with function body.

func _on_on_mouse_body_exited(_body: Node2D) -> void:
	blockedNum -= 1
	if myceliumNum > 0 && blockedNum == 0:
		$OnMouse/Sprite2D.modulate = Color(0,255,0,0.5)
		pass
	pass # Replace with function body.



func _on_area_2d_area_entered(_area: Area2D) -> void:
	myceliumNum += 1
	if blockedNum == 0:
		$OnMouse/Sprite2D.modulate = Color(0,255,0,0.5)
	pass # Replace with function body.

func _on_area_2d_area_exited(_area: Area2D) -> void:
	myceliumNum -= 1
	if myceliumNum == 0:
		$OnMouse/Sprite2D.modulate = Color(255,0,0,0.5)
	pass # Replace with function body.
