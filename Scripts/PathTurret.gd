extends CharacterBody2D

var maxHealth = 50.0
var turretHealth = 50.0
var timer = 0

func _ready():
	add_to_group("turrets")
	add_to_group('navigation')

func _process(delta: float) -> void:
	if turretHealth <= 0:
		queue_free()
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1:
		var crystals = Global.read("gemCount")
		Global.write("gemCount", int(crystals)-1)
		timer -= 1
