extends CharacterBody2D

var maxHealth = 100.0
var turretHealth = 100.0
var timer = 0
var closestFire = []

func _ready():
	add_to_group("turrets")
	add_to_group('navigation')
	$AOE.global_position = Vector2(0,0)

func _process(delta: float) -> void:
	if turretHealth <= 0:
		queue_free()
	#print(closestFire)
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 3 && closestFire != []:
		Global.data["gemCount"] -= 3
		timer -= 3
		var deleted = 0
		
		for i in range(closestFire.size()):
			if !is_instance_valid(closestFire[i - deleted]):
				closestFire.remove_at(i - deleted)
				deleted += 1
		
		if closestFire != []:
			$AOE/CollisionShape2D.position = closestFire[0].position
			var allFires = $AOE.get_overlapping_bodies()
			print(allFires)
			for i in range(allFires.size()):
				print('hurt')
				allFires[i].fireHealth -= 40
			$AOE.global_position = Vector2(0,0)
			print('shoot and recall')
		
	
	elif timer >= 3:
		
		Global.data["gemCount"] -= 3
		timer -= 3

func _on_area_2d_body_entered(body: Node2D) -> void:
	closestFire.append(body)
