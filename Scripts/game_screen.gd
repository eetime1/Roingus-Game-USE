extends Node2D

var shroom
var placeshroom := load("res://Assets/SFX/placeshroom.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GUI.turret_instantiate.connect(instance)
	pass # Replace with function body.

func instance(mushroom = null) -> void:
	match (mushroom):
		"turret":
			shroom = load("res://Scenes/Characters/TurretPlain.tscn")
		"path":
			shroom = load("res://Scenes/Characters/TurretPath.tscn")
		"wall":
			shroom = load("res://Scenes/Characters/TurretWall.tscn")
		"heal":
			shroom = load("res://Scenes/Characters/TurretHeal.tscn")
		"spore":
			shroom = load("res://Scenes/Characters/TurretSpore.tscn")
		_:
			shroom = null
			
	if mushroom != null:
		Global.data["gemCount"] -= Global.mushroomsCost[mushroom]
		
	if shroom:
		AudioManager.play_audio_oneshot(placeshroom)
		var a = shroom.instantiate()
		$Level.add_child(a)
		a.position = $Level.get_local_mouse_position()
		#print(a.position)
		
