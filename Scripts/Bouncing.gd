extends Sprite2D
var skewDirection = 1
var skewIncrem = 0.01

func _physics_process(_delta: float) -> void:
	if skewDirection == 1:
		skew += skewIncrem
	elif skewDirection == -1:
		skew -= skewIncrem
	
	if skew >= 0.1:
		skewDirection = -1
	elif skew <= -0.1:
		skewDirection = 1
