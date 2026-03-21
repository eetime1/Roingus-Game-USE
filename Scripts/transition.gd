extends Control

var come = false
signal came
var go = false
signal went

func _process(delta: float) -> void:
	
	if $HBoxContainer.position.x >= 0 && come == true:
		come = false
		emit_signal("came")
	
	if $HBoxContainer.position.x <= -1280 && go == true:
		go = false
		visible = false
		emit_signal("went")
	
	if come:
		$HBoxContainer.position.x += 64
		$HBoxContainer2.position.x -= 64
	elif go:
		$HBoxContainer.position.x -= 64
		$HBoxContainer2.position.x += 64
	

func dothething():
	come = true
	visible = true
	pass

func goaway():
	go = true
	pass
