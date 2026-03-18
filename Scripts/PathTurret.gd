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
		Global.data["gemCount"] -= 1
		timer -= 1
