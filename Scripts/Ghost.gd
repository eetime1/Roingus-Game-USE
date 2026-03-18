extends Area2D

@onready var heldShroom = get_parent().isHoldingWhat

func _ready() -> void:
	pass

func _on_gui_change_held() -> void:
	heldShroom = get_parent().isHoldingWhat
	match (heldShroom):
		"path":
			$Sprite2D.texture = load("res://Assets/Sprites/PathShroom.png")
			$CollisionShape2D.shape.radius = 600
			$Area2D/CollisionShape2D.shape.radius = 600
		"turret":
			$Sprite2D.texture = load("res://Assets/Sprites/PlainShroomDR.png")
			$CollisionShape2D.shape.radius = 600
			$Area2D/CollisionShape2D.shape.radius = 600
		"wall":
			$Sprite2D.texture = load("res://Assets/Placeholders/PlainShroomPlaceholder.png")
			$CollisionShape2D.shape.radius = 1280
			$Area2D/CollisionShape2D.shape.radius = 1280
		"heal":
			$Sprite2D.texture = load("res://Assets/Placeholders/PlainShroomPlaceholder.png")
			$CollisionShape2D.shape.radius = 600
			$Area2D/CollisionShape2D.shape.radius = 600
		_:
			$Sprite2D.texture = null
	$Sprite2D.modulate = Color(255, 0, 0, 0.5)
	
