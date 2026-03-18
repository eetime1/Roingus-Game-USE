extends CharacterBody2D

var fireHealth = 10.0
var timer = 0
var turretsInRange = []
var detChangeHP = 10.0

func _ready() -> void:
	pass

func raycastAndRandomize(angle:Vector2) -> float:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position + Vector2(0, 0), position + 2560*angle, 0b1010)
	var result = space_state.intersect_ray(query)
	
	var longestDistance = 2560
	if result:
		longestDistance = (result.position - position).length()
		if longestDistance <= 1280:
			return 0
	
	return randf_range(1280,longestDistance)

func _process(delta: float) -> void:
	if detChangeHP != fireHealth:
		detChangeHP = fireHealth
		$Sprite2D.scale = Vector2(fireHealth / 100, fireHealth / 100)
	timer += delta
	
	if timer >= 1 && turretsInRange != []:
		var deleted = 0
		for i in range(turretsInRange.size()):
			if !is_instance_valid(turretsInRange[i - deleted]):
				turretsInRange.remove_at(i - deleted)
				deleted += 1
		
		if turretsInRange != []:
			timer -= 1
			turretsInRange[0].turretHealth -= 50
			fireHealth -= 50
	
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
				get_parent().get_child(-1).fireHealth = randf_range(1, 20)
				fireHealth -= 50.0
				isTrapped = false
				break
			randomAngle += PI / 30
			randomAngleVector = Vector2(cos(randomAngle), sin(randomAngle)).normalized()
		if isTrapped:
			queue_free()
			
	if fireHealth <= 0:
		queue_free()
	
	elif timer >= 1:
		timer -= 1
		fireHealth += 10


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		turretsInRange.append(body)
	
