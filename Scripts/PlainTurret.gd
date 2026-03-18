extends CharacterBody2D

var turretHealth = 100.0
var timer = 0
var closestFire = []
var fireDist = []

func _ready():
	add_to_group("turrets")
	add_to_group('navigation')

func _process(delta: float) -> void:
	if turretHealth <= 0:
		queue_free()
	
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1 && closestFire != []:
		Global.data["gemCount"] -= 1
		
		var deleted = 0
		for i in range(closestFire.size()):
			if !is_instance_valid(closestFire[i - deleted]):
				closestFire.remove_at(i - deleted)
				deleted += 1
		
		if closestFire != []:
			timer -= 1
			closestFire[0].fireHealth -= 50
			if closestFire[0].fireHealth <= 0:
				closestFire[0].queue_free()
		
	elif timer >= 1:
		timer -= 1
		Global.data["gemCount"] -= 1
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	closestFire.append(body)
