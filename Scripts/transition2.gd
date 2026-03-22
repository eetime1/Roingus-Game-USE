extends Control

var move = false
var met = false

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
	
func _process(delta: float) -> void:
	
	if $CanvasLayer/TextureRect.position.x >= minimums && move == true:
		await get_tree().create_timer(0.5).timeout
		met = true
		if $CanvasLayer/TextureRect.position.x >= minimums:
			$CanvasLayer/TextureRect.position.x = minimums
			$CanvasLayer/TextureRect2.position.x = minimums
	
	if $CanvasLayer/TextureRect.position.x <= -minimums && met == true:
		move = false
		met = false
		if $CanvasLayer/TextureRect.position.x <= -minimums:
			$CanvasLayer/TextureRect.position.x = -minimums
			$CanvasLayer/TextureRect2.position.x = -minimums
	
	if move && !met:
		$CanvasLayer/TextureRect.position.x += 32 * (minimums / 1280) * (delta * multiplier)
		$CanvasLayer/TextureRect2.position.x -= 32 * (minimums / 1280) * (delta * multiplier)

	elif move && met:
		$CanvasLayer/TextureRect.position.x -= 32 * (minimums / 1280) * (delta * multiplier)
		$CanvasLayer/TextureRect2.position.x += 32 * (minimums / 1280) * (delta * multiplier)

func dothething():
	move = true
	pass
