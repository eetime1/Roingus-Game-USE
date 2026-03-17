extends StaticBody2D

var turretHealth = 100.0
var timer = 0
var closestFire = []

func _ready():
	add_to_group("turrets")

func _process(delta: float) -> void:
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1 && closestFire != []:
		timer -= 1
		closestFire[0].fireHealth -= 50
		if closestFire[0].fireHealth <= 0:
			closestFire[0].queue_free()
			closestFire.remove_at(0)
	elif timer >= 2:
		timer -= 1
	
	if turretHealth <= 0:
		#print('KIA')
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	closestFire.append(body)
