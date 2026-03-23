extends Control

func _ready():
	$CanvasLayer/FpsCounts.visible = Global.read("showFPS")

func _process(_delta: float) -> void:
	$CanvasLayer/Health.value = int(Global.data["health"])
	$CanvasLayer/Crystals/Label2.text = str(Global.data["gemCount"])
	$CanvasLayer/Roingus/Label2.text = str(Global.data["roingusCount"], " / 25")
	
	if $CanvasLayer/Panel2/Secret.modulate.a > 0.02:
		$CanvasLayer/Panel2/Secret.modulate.a = (1 - ($CanvasLayer/AudioStreamPlayer2D.get_playback_position() / 1.25))
		$CanvasLayer/Panel2/Secret.self_modulate.a = (1 - ($CanvasLayer/AudioStreamPlayer2D.get_playback_position() / 1.25))
	else:
		$CanvasLayer/Panel2/Secret.modulate.a = 0
	
	$CanvasLayer/FpsCounts.text = "FPS: " + str(Engine.get_frames_per_second())
	if Global.read("showFPS"):
		$CanvasLayer/FpsCounts.visible = true
	elif !Global.read("showFPS"):
		$CanvasLayer/FpsCounts.visible = false

func _open_build_menu():
	var positionChange = 350
	var positionMinimum = -100
	if $CanvasLayer/BuildMenu.position.y - DisplayServer.window_get_size().y > positionMinimum:
		$CanvasLayer/BuildMenu.position.y -= positionChange
	else:
		$CanvasLayer/BuildMenu.position.y += positionChange
		
func _summoning_mushroom(_extra_arg_0: String) -> void:
	# This method has been moved to Ghost.gd
	# It is still here because I'm lazy and keeping it stops errors
	# The errors are from the Menu bar buttons - Summoning shrooms
	
	Global.hotfixHeld = _extra_arg_0
	
	pass
