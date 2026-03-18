extends CharacterBody2D

const movement_speed = 2000.0
@onready var nav_agent : Node  = $NavigationAgent2D
@onready var movementPaused = false
var timer = 0.0

@onready var burrow = $"../Burrow1"
@onready var home = $"../HomeShroom"
@onready var navmesh = $"../NavigationRegion2D"

func _ready() -> void:
	nav_agent.target_position = burrow.global_position

func _physics_process(delta: float) -> void:
	
	if timer >= 1:
		navmesh.bake_navigation_polygon()
		timer -=1
	else:
		timer += delta
	
	if !nav_agent.is_navigation_finished() && !movementPaused:
		var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = nav_point_direction * movement_speed
		move_and_slide()
		
	elif nav_agent.target_position == burrow.global_position && !movementPaused:
		$Sprite2DEmpty.visible = false
		nav_agent.target_position = home.global_position
		movementPaused = true
		await get_tree().create_timer(1).timeout
		$Sprite2DFull.visible = true
		movementPaused = false
	
	elif nav_agent.target_position == home.global_position && !movementPaused:
		$Sprite2DFull.visible = false
		var gemSum = int(Global.read("gemCount")) + 50
		
		Global.write("gemCount", str(gemSum))
		nav_agent.target_position = burrow.global_position
		movementPaused = true
		await get_tree().create_timer(1).timeout
		$Sprite2DEmpty.visible = true
		movementPaused = false
	
	if !nav_agent.is_target_reachable():
		$Sprite2DFull.visible = false
		$Sprite2DEmpty.visible = true
		nav_agent.target_position = burrow.global_position
		movementPaused = false
		position = home.global_position + Vector2(0,100)
		
	
