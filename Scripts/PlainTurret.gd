extends StaticBody2D

var turretHealth = 100.0
var closestFire
var timer = 0

func _process(delta: float) -> void:
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1 && closestFire:
		timer -= 1
		print("SHOOT")
		closestFire.fireHealth -= 50
		if closestFire.fireHealth <= 0:
			closestFire = null
	elif timer >= 2:
		print('TIMER')
		timer -= 1
	
	if turretHealth <= 0:
		print('KIA')
		queue_free()

func _on_fire_enter_area(body: Node2D) -> void:
	closestFire = body
	print('FIRE DETECTED')
