extends Area2D

@onready var heldShroom = get_parent().isHoldingWhat

func _ready() -> void:
	pass

func _on_gui_change_held() -> void:
	heldShroom = get_parent().isHoldingWhat
	match (heldShroom):
		"path":
			print('ghost working')
			$Sprite2D.texture = load("res://Assets/Sprites/PathShroom.png")
			$CollisionShape2D.shape.radius = 400
			$Area2D/CollisionShape2D.shape.radius = 400
		"turret":
			$Sprite2D.texture = load("res://Assets/Sprites/PlainShroomDR.png")
			$CollisionShape2D.shape.radius = 400
			$Area2D/CollisionShape2D.shape.radius = 400
		"wall":
			$Sprite2D.texture = load("res://Assets/Sprites/WallShroom.png")
			$CollisionShape2D.shape.radius = 1200
			$Area2D/CollisionShape2D.shape.radius = 1200
		"heal":
			$Sprite2D.texture = load("res://Assets/Sprites/HealShroom.png")
			$CollisionShape2D.shape.radius = 400
			$Area2D/CollisionShape2D.shape.radius = 400
		"spore":
			$Sprite2D.texture = load("res://Assets/Sprites/SporeShroom.png")
			$CollisionShape2D.shape.radius = 400
			$Area2D/CollisionShape2D.shape.radius = 400
		"delete":
			$Sprite2D.texture = load("res://Assets/Sprites/Building_Icon.png")
			$CollisionShape2D.shape.radius = 10
			$Area2D/CollisionShape2D.shape.radius = 10
		_:
			$Sprite2D.texture = null
	$Sprite2D.modulate = Color(255, 0, 0, 0.5)
	if heldShroom == 'delete':
		$Sprite2D.modulate = Color(0, 0, 0, 0.5)
	
