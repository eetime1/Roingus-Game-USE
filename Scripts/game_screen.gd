extends Node2D

var shroom
var placeshroom := load("res://Assets/SFX/placeshroom.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Ghost.turret_instantiate.connect(instance)
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if Global.hotfixHeld != null && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		match (Global.hotfixHeld):
			"turret":
				shroom = load("res://Scenes/Characters/TurretPlain.tscn")
			"path":
				shroom = load("res://Scenes/Characters/Turretpath.tscn")
			"wall":
				shroom = load("res://Scenes/Characters/TurretWall.tscn")
			"heal":
				shroom = load("res://Scenes/Characters/TurretHeal.tscn")
			"spore":
				shroom = load("res://Scenes/Characters/TurretSpore.tscn")
			_:
				shroom = null

		if Global.hotfixHeld != null:
			Global.data["gemCount"] -= Global.mushroomsCost[Global.hotfixHeld]
			
		if shroom:
			AudioManager.play_audio_oneshot(placeshroom)
			var a = shroom.instantiate()
			$Level.add_child(a)
			a.position = Vector2(get_global_mouse_position() + Vector2(0, 640))
			#print(a.position)
		Global.hotfixHeld = null

func instance(mushroom = null) -> void:
	match (mushroom):
		"turret":
			shroom = load("res://Scenes/Characters/TurretPlain.tscn")
		"path":
			shroom = load("res://Scenes/Characters/Turretpath.tscn")
		"wall":
			shroom = load("res://Scenes/Characters/TurretWall.tscn")
		"heal":
			shroom = load("res://Scenes/Characters/TurretHeal.tscn")
		"spore":
			shroom = load("res://Scenes/Characters/TurretSpore.tscn")
		_:
			shroom = null
