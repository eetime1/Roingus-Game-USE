extends CharacterBody2D

const movement_speed = 2000.0
@onready var nav_agent : Node  = $NavigationAgent2D
var timer = 0.0

var burrow
@onready var home = $"../HomeShroom"
@onready var navmesh = $"../NavigationRegion2DCIV"

@onready var diffGoal = nav_agent.get_next_path_position()
@onready var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()

signal roingusHome

func _ready() -> void:
	nav_agent.target_position = home.global_position
	

func _physics_process(delta: float) -> void:
	
	if timer >= 1:
		navmesh.bake_navigation_polygon()
		timer -=1
	else:
		timer += delta
	
	if !nav_agent.is_navigation_finished():
		if nav_point_direction != diffGoal:
			nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = nav_point_direction * movement_speed
		move_and_slide()
		
	elif nav_agent.target_position == home.global_position:
		emit_signal("roingusHome")
		queue_free()
	
	if !nav_agent.is_target_reachable():
		position = burrow.global_position
		
	
