extends CharacterBody2D

var maxHealth = 100.0
var turretHealth = 100.0
var timer = 0
var closestTurret = []
var heal = load("res://Assets/SFX/heal.wav")
var gemTimer = 0

func _ready():
	add_to_group("turrets")
	add_to_group('navigation')

func _process(delta: float) -> void:
	if turretHealth <= 0:
		queue_free()
	
	$ProgressBar.value = turretHealth
	timer += delta
	gemTimer += delta
	
	if timer >= 1 && closestTurret != []:
		timer -= 1
		
		var deleted = 0
		for i in range(closestTurret.size()):
			if !is_instance_valid(closestTurret[i - deleted]):
				closestTurret.remove_at(i - deleted)
				deleted += 1
		
		if closestTurret != []:
			for i in range(closestTurret.size()):
				if closestTurret[i].turretHealth <= closestTurret[i].maxHealth - 25:
					print('heal')
					AudioManager.play_audio_oneshot(heal)
					closestTurret[0].turretHealth += 25
					break
	elif timer >= 2:
		Global.data["gemCount"] -= 1
		timer -= 1
	
	if gemTimer >= 5:
		Global.data["gemCount"] -= 1
		gemTimer -= 5

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		closestTurret.append(body)
