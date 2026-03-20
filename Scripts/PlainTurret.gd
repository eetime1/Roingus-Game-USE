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
			
			var xoff = closestFire[0].position.x - position.x
			var yoff = closestFire[0].position.y - position.y
			
			if xoff > 200 && abs(yoff) <= 200:
				$PlainShroomRight.visible = true
				$PlainShroomRight.flip_h = false
				$PlainShroomRight.offset.x = 150
				
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			elif xoff > 200 && yoff > 200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				
				$PlainShroomDr.visible = true
				$PlainShroomDr.flip_h = false
				$PlainShroomDr.offset.x = 40
				
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			elif xoff > 200 && yoff < -200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				
				$PlainShroomUr.visible = true
				$PlainShroomUr.flip_h = false
			elif abs(xoff) <= 200 && yoff < -200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				
				$PlainShroomUp.visible = true
				
				$PlainShroomUr.visible = false
			elif abs(xoff) <= 200 && yoff < -200:
				$PlainShroomRight.visible = false
				
				$PlainShroomDown.visible = true
				
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			elif xoff < -200 && yoff < -200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				
				$PlainShroomUr.visible = true
				$PlainShroomUr.flip_h = true
			elif xoff < -200 && yoff > 200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				
				$PlainShroomDr.visible = true
				$PlainShroomDr.flip_h = true
				$PlainShroomDr.offset.x = -40
				
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			elif xoff < -200 && abs(yoff) <= 200:
				$PlainShroomRight.visible = true
				$PlainShroomRight.flip_h = true
				$PlainShroomRight.offset.x = -150
				
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			
			closestFire[0].fireHealth -= 50
			
		
	elif timer >= 1:
		timer -= 1
		Global.data["gemCount"] -= 1
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	closestFire.append(body)
