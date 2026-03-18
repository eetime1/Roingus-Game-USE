extends CharacterBody2D

var maxHealth = 100.0
var turretHealth = 100.0
var timer = 0
var closestFire = []

func _ready():
	add_to_group("turrets")
	add_to_group('navigation')

func _process(delta: float) -> void:
	if turretHealth <= 0:
		queue_free()
	
	print(closestFire)
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
			
			$AOE.global_position = closestFire[0].global_position
			
			$AOE.global_position = Vector2(0,0)
			print('shoot and recall')
			
			
	elif timer >= 1:
		Global.data["gemCount"] -= 1
		timer -= 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	closestFire.append(body)

func _on_aoe_body_entered(body: Node2D) -> void:
	print('aoe')
	body.fireHealth -= 1000
