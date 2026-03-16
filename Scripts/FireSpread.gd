extends StaticBody2D

var fireHealth = 10.0
var timer = 0

func raycastAndRandomize(angle:Vector2) -> float:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position + Vector2(0, 0), position + 2560*angle, 0b10)
	var result = space_state.intersect_ray(query)
	
	var longestDistance = 2560
	if result:
		longestDistance = (result.position - position).length()
		if longestDistance <= 1280:
			return 0
	
	return randf_range(1280,longestDistance)

func _process(delta: float) -> void:
	$Sprite2D.scale = Vector2(fireHealth / 100, fireHealth / 100)
	$ProgressBar.value = fireHealth
	timer += delta
	
	if fireHealth >= 100 && timer >= 1:
		
		var randomAngle = randf_range(0, 2*PI)
		var randomAngleVector = Vector2(cos(randomAngle), sin(randomAngle)).normalized()
		var isTrapped = true
		
		for i in range(59):
			var newSpaceCheck = raycastAndRandomize(randomAngleVector)
			if newSpaceCheck != 0:
				var dup = self.duplicate()
				get_parent().add_child(dup)
				get_parent().get_child(-1).position = position + newSpaceCheck * randomAngleVector
				get_parent().get_child(-1).add_to_group('navigation')
				fireHealth -= 50.0
				isTrapped = false
				break
			randomAngle += PI / 30
		if isTrapped:
			queue_free()
		
	elif timer >= 1:
		timer -= 1
		fireHealth += 10
