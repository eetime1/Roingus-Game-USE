extends Control

var come = false
signal came
var go = false
signal went

var minimums = Global.read("screenX")
var minimumsY = Global.read("screenY")
var multiplier = 100

func _ready():
	$CanvasLayer/TextureRect2.size.x = minimums
	$CanvasLayer/TextureRect.size.x = minimums
	
	$CanvasLayer/TextureRect.size.y = minimumsY 
	$CanvasLayer/TextureRect2.size.y = minimumsY 
	
	$CanvasLayer/TextureRect2.position.x = minimums
	$CanvasLayer/TextureRect.position.x = -minimums
	
	$CanvasLayer/TextureRect2.position.y = 0
	$CanvasLayer/TextureRect.position.y = 0
	
	pass
	
func _process(delta: float) -> void:
	if $CanvasLayer/TextureRect.position.x >= 0 && come == true:
		come = false
		emit_signal("came")
	
	if $CanvasLayer/TextureRect.position.x <= -minimums && go == true:
		go = false
		visible = false
		emit_signal("went")
	
	if come:
		$CanvasLayer/TextureRect.position.x += 32 * (minimums / 1280) *  (delta * multiplier)
		$CanvasLayer/TextureRect2.position.x -= 32 * (minimums / 1280) * (delta * multiplier)
		if $CanvasLayer/TextureRect.position.x >= 0:
			$CanvasLayer/TextureRect.position.x = 0
			$CanvasLayer/TextureRect2.position.x = 0
		#print('coming')
	if go:
		$CanvasLayer/TextureRect.position.x -= 32 * (minimums / 1280) * (delta * multiplier)
		$CanvasLayer/TextureRect2.position.x += 32 * (minimums / 1280) * (delta * multiplier)
		if $CanvasLayer/TextureRect.position.x <= -minimums:
			$CanvasLayer/TextureRect.position.x = -minimums
			$CanvasLayer/TextureRect2.position.x = minimums
func fixYourself():
	minimums = Global.read("screenX")
	minimumsY = Global.read("screenY")
	
	$CanvasLayer/TextureRect2.size.x = minimums
	$CanvasLayer/TextureRect.size.x = minimums
	$CanvasLayer/TextureRect.size.y = minimumsY 
	$CanvasLayer/TextureRect2.size.y = minimumsY 
	
	$CanvasLayer/TextureRect2.position.x = minimums
	$CanvasLayer/TextureRect.position.x = -minimums
	
	$CanvasLayer/TextureRect2.position.y = 0
	$CanvasLayer/TextureRect.position.y = 0
	
	prints($CanvasLayer/TextureRect2.size.x, $CanvasLayer/TextureRect2.size.y,$CanvasLayer/TextureRect2.position.x,$CanvasLayer/TextureRect2.position.y  )

func dothething():
	come = true
	visible = true
	pass

func goaway():
	go = true
	pass
