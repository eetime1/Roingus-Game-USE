extends CharacterBody2D

const movement_speed = 2000.0
signal gems_get
@onready var nav_agent : Node  = $NavigationAgent2D
@onready var movementPaused = false
var timer = 0

func _ready() -> void:
	nav_agent.target_position = get_parent().get_child(3).global_position
	


func _physics_process(delta: float) -> void:
	
	if timer >= 0.5:
		get_parent().get_child(1).bake_navigation_polygon
		nav_agent.get_next_path_position()
		timer -=0.5
		print('fearuygkeawrkguy')
	else:
		timer += delta
	
	if !nav_agent.is_navigation_finished() && !movementPaused:
		var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = nav_point_direction * movement_speed
		move_and_slide()
		
	
	elif nav_agent.target_position == get_parent().get_child(3).global_position && !movementPaused:
		$Sprite2DEmpty.visible = false
		nav_agent.target_position = get_parent().get_child(4).global_position
		movementPaused = true
		await get_tree().create_timer(1).timeout
		$Sprite2DFull.visible = true
		movementPaused = false
		
	
	elif nav_agent.target_position == get_parent().get_child(4).global_position && !movementPaused:
		$Sprite2DFull.visible = false
		emit_signal("gems_get")
		nav_agent.target_position = get_parent().get_child(3).global_position
		movementPaused = true
		await get_tree().create_timer(1).timeout
		$Sprite2DEmpty.visible = true
		movementPaused = false
		
		
	
