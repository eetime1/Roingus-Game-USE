extends StaticBody2D

var turretHealth = 100.0
var timer = 0
var closestFire = []

func _process(delta: float) -> void:
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1 && closestFire != []:
		timer -= 1
		print("SHOOT")
		closestFire[0].fireHealth -= 50
		if closestFire[0].fireHealth <= 0:
			closestFire[0].queue_free()
			closestFire.remove_at(0)
	elif timer >= 2:
		timer -= 1
	
	if turretHealth <= 0:
		print('KIA')
		queue_free()


func _on_fire_shootme(thisguy) -> void:
	if (position - thisguy.position).length() <= 5120:
		closestFire.append(thisguy)
