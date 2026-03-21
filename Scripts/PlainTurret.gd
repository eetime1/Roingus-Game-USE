extends CharacterBody2D

var maxHealth = 100.0
var turretHealth = 100.0
var timer = 0
var closestFire = []
var plainfire = load("res://Assets/SFX/plainfire.wav")

func _ready():
	add_to_group("turrets")
	add_to_group('navigation')

func _process(delta: float) -> void:
	if turretHealth <= 0:
		queue_free()
	
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1 && closestFire != []:
		$Hitmarker.visible = true
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
				$Hitmarker.rotation = 0
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
				$Hitmarker.rotation = PI/4
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			elif xoff > 200 && yoff < -200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				$Hitmarker.rotation = -PI/4
				$PlainShroomUr.visible = true
				$PlainShroomUr.flip_h = false
			elif abs(xoff) <= 200 && yoff < -200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				
				$PlainShroomUp.visible = true
				$Hitmarker.rotation = -PI/2
				$PlainShroomUr.visible = false
			elif abs(xoff) <= 200 && yoff < -200:
				$PlainShroomRight.visible = false
				
				$PlainShroomDown.visible = true
				$Hitmarker.rotation = PI/2
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			elif xoff < -200 && yoff < -200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				$Hitmarker.rotation = -3*PI/4
				$PlainShroomUr.visible = true
				$PlainShroomUr.flip_h = true
			elif xoff < -200 && yoff > 200:
				$PlainShroomRight.visible = false
				$PlainShroomDown.visible = false
				
				$PlainShroomDr.visible = true
				$PlainShroomDr.flip_h = true
				$PlainShroomDr.offset.x = -40
				$Hitmarker.rotation = 3*PI/4
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			elif xoff < -200 && abs(yoff) <= 200:
				$PlainShroomRight.visible = true
				$PlainShroomRight.flip_h = true
				$PlainShroomRight.offset.x = -150
				$Hitmarker.rotation = PI
				$PlainShroomDown.visible = false
				$PlainShroomDr.visible = false
				$PlainShroomUp.visible = false
				$PlainShroomUr.visible = false
			$Hitmarker.global_position = closestFire[0].global_position
			closestFire[0].fireHealth -= 50
			AudioManager.play_audio_oneshot(plainfire)
			
		
	elif timer >= 1:
		$Hitmarker.visible = false
		timer -= 1
		Global.data["gemCount"] -= 1
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		closestFire.append(body)
