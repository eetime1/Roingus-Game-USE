extends Node2D

signal turret_instantiate
signal turret_instantiate_tutorial
#signal changeHeld

var blockedNum = 0
var myceliumNum = 0
var isHoldingWhat = null
var heldShroom = isHoldingWhat

var deletable
var deleteshroom = load("res://Assets/SFX/deleteshroom.wav")
var fail2place = load("res://Assets/SFX/fail2place.wav")
var fail2place2 = load("res://Assets/SFX/fail2place2.wav")

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	$OnMouse.global_position = get_global_mouse_position()
	if Global.hotfixHeld != null:
		#print(Global.hotfixHeld)
		_summoning_mushroom(Global.hotfixHeld)
		#Global.hotfixHeld = null
		
	
func _input(event):
	if event is InputEventMouseButton:
		
		if event.button_index == 2 && isHoldingWhat != null:
			isHoldingWhat = null
			#emit_signal("changeHeld")
			_on_gui_change_held()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			#print('cancelled')
		
		if event.button_index == 1 && isHoldingWhat == "delete" && deletable != null:
			#print("delete", deletable)
			AudioManager.play_audio_oneshot(deleteshroom)
			
			deletable.queue_free()
			isHoldingWhat = null
			#emit_signal("changeHeld")
			_on_gui_change_held()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			pass
		
		if event.button_index == 1 && isHoldingWhat != null && blockedNum == 0 && myceliumNum > 0:
			print('gui detect conditions')
			if get_parent().name == "TutorialGame":
				turret_instantiate_tutorial.emit(isHoldingWhat)
			else:
				print('gui working')
				turret_instantiate.emit(isHoldingWhat)
			isHoldingWhat = null
			#emit_signal("changeHeld")
			_on_gui_change_held()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif event.button_index == 1 && isHoldingWhat != null && blockedNum != 0 && event.pressed:
			#print('blocked')
			if randi() % 2 == 0:
				AudioManager.play_audio_oneshot(fail2place)
			else:
				AudioManager.play_audio_oneshot(fail2place2)
			pass
		#elif event.button_index == 1 && isHoldingWhat != null && myceliumNum == 0 && event.pressed:
			#
			#if Global.read("noMycelium") == true:
				#$CanvasLayer/AudioStreamPlayer2D.position = Global.globalPosition
				#$CanvasLayer/AudioStreamPlayer2D.play()
				#$CanvasLayer/Panel2/Secret.modulate.a = 1
				#print('
#---------------------------------------
#⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝
#⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇
#⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀
#⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀
#⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀
#⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀
#⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
#----------no mycelium???????----------')
			#else:
				#print("Not on mycelium")
				#pass
				
func _on_gui_change_held() -> void:
	heldShroom = isHoldingWhat
	match (heldShroom):
		"path":
			print('ghost working')
			$OnMouse/Sprite2D.texture = load("res://Assets/Sprites/PathShroom.png")
			$OnMouse/CollisionShape2D.shape.radius = 400
			$OnMouse/Area2D/CollisionShape2D.shape.radius = 400
		"turret":
			$OnMouse/Sprite2D.texture = load("res://Assets/Sprites/PlainShroomDR.png")
			$OnMouse/CollisionShape2D.shape.radius = 400
			$OnMouse/Area2D/CollisionShape2D.shape.radius = 400
		"wall":
			$OnMouse/Sprite2D.texture = load("res://Assets/Sprites/WallShroom.png")
			$OnMouse/CollisionShape2D.shape.radius = 1200
			$OnMouse/Area2D/CollisionShape2D.shape.radius = 1200
		"heal":
			$OnMouse/Sprite2D.texture = load("res://Assets/Sprites/HealShroom.png")
			$OnMouse/CollisionShape2D.shape.radius = 400
			$OnMouse/Area2D/CollisionShape2D.shape.radius = 400
		"spore":
			$OnMouse/Sprite2D.texture = load("res://Assets/Sprites/SporeShroom.png")
			$OnMouse/CollisionShape2D.shape.radius = 400
			$OnMouse/Area2D/CollisionShape2D.shape.radius = 400
		"delete":
			$OnMouse/Sprite2D.texture = load("res://Assets/Sprites/Building_Icon.png")
			$OnMouse/CollisionShape2D.shape.radius = 10
			$OnMouse/Area2D/CollisionShape2D.shape.radius = 10
		_:
			$SOnMouse/prite2D.texture = null
	$OnMouse/Sprite2D.modulate = Color(255, 0, 0, 0.5)
	if heldShroom == 'delete':
		$OnMouse/Sprite2D.modulate = Color(0, 0, 0, 0.5)
	
func _summoning_mushroom(extra_arg_0: String) -> void:
	if int(Global.data["gemCount"]) > Global.mushroomsCost[extra_arg_0]:
		isHoldingWhat = extra_arg_0
		#emit_signal("changeHeld")
		_on_gui_change_held()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		print("worked")
	else:
		print("workednt")
		#print("broke asf")
		pass

	
func _on_on_mouse_body_entered(_body: Node2D) -> void:
	#print('detected body')
	blockedNum += 1
	if isHoldingWhat != "delete":
		
		$OnMouse/Sprite2D.modulate = Color(255,0,0,0.5)
	pass # Replace with function body.

func _on_on_mouse_body_exited(_body: Node2D) -> void:
	blockedNum -= 1
	if isHoldingWhat != "delete":
		
		if myceliumNum > 0 && blockedNum == 0:
			$OnMouse/Sprite2D.modulate = Color(0,255,0,0.5)
			pass
	pass # Replace with function body.

func _on_area_2d_area_entered(_area: Area2D) -> void:
	myceliumNum += 1
	if isHoldingWhat != "delete":
		
		if blockedNum == 0:
			$OnMouse/Sprite2D.modulate = Color(0,255,0,0.5)
	pass # Replace with function body.

func _on_area_2d_area_exited(_area: Area2D) -> void:
	myceliumNum -= 1
	if isHoldingWhat != "delete":
		
		if myceliumNum == 0:
			$OnMouse/Sprite2D.modulate = Color(255,0,0,0.5)
	pass # Replace with function body.


func _on_turret_detector_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D && isHoldingWhat == "delete" && body.name != "HomeShroom":
		#print('turret detected')
		$OnMouse/Sprite2D.modulate = Color(255,0,0,0.5)
		deletable = body
	else:
		deletable = null
	pass # Replace with function body.

func _on_turret_detector_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D && isHoldingWhat == "delete":
		#print('turret undetected')
		$OnMouse/Sprite2D.modulate = Color(0,0,0,0.5)
		deletable = null
	pass # Replace with function body.
