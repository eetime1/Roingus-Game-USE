extends StaticBody2D

var turretHealth = 100.0
var timer = 0

func raycastTurret(angle:Vector2 = Vector2(1,0), distance:float = 100) -> float:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position + Vector2(0, 0), position + distance*angle, 0b100)
	var result = space_state.intersect_ray(query)
	var finalDistance = 0
	
	if result:
		finalDistance = (result.position - position).length()
	return finalDistance

func _process(delta: float) -> void:
	$Sprite2D.scale = Vector2(turretHealth / 100, turretHealth / 100)
	$ProgressBar.value = turretHealth
	timer += delta
	
	if timer >= 1:
		var randomAngle = randf_range(0, 2*PI)
		var randomAngleVector = Vector2(cos(randomAngle), sin(randomAngle)).normalized()
		for i in range(59):
			var newSpaceCheck = raycastTurret(randomAngleVector, 2560)
			var hit = false
			if newSpaceCheck:
				hit = true
				
			if hit:
				break
			randomAngle += PI / 30
			randomAngleVector = Vector2(cos(randomAngle), sin(randomAngle)).normalized()
			
		
		if turretHealth <= 0:
			queue_free()
