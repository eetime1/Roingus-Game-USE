extends Sprite2D
var skewDirection = 1

func _physics_process(delta: float) -> void:
	if skewDirection == 1:
		skew += 0.01
	elif skewDirection == -1:
		skew -= 0.01
	
	if skew >= 0.1:
		skewDirection = -1
	elif skew <= -0.1:
		skewDirection = 1
