extends Control

var move = false
var met = false

func _process(delta: float) -> void:
	
	if $HBoxContainer.position.x >= 0 && move == true:
		await get_tree().create_timer(0.5).timeout
		met = true
	
	if $HBoxContainer.position.x <= -1280 && met == true:
		move = false
		met = false
	
	if move && !met:
		$HBoxContainer.position.x += 64
		$HBoxContainer2.position.x -= 64
	elif move && met:
		$HBoxContainer.position.x -= 64
		$HBoxContainer2.position.x += 64
	

func dothething():
	move = true
	pass
