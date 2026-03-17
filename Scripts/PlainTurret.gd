extends StaticBody2D

var turretHealth = 100.0
var timer = 0
var closestFire = []
var fireDist = []

func _ready():
	add_to_group("turrets")

func _process(delta: float) -> void:
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1 && closestFire != []:
		var deleted = 0
		for i in range(closestFire.size()):
			if !is_instance_valid(closestFire[i - deleted]):
				closestFire.remove_at(i - deleted)
				deleted += 1
		
		if closestFire != []:
			timer -= 1
			print(closestFire)
			closestFire[0].fireHealth -= 50
			if closestFire[0].fireHealth <= 0:
				closestFire[0].queue_free()
	elif timer >= 2:
		timer -= 1
	
	if turretHealth <= 0:
		#print('KIA')
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	closestFire.append(body)
