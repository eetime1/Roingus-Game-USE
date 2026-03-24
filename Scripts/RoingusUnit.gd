extends CharacterBody2D

const movement_speed = 2000.0
@onready var nav_agent : Node  = $NavigationAgent2D
var movementPaused = false
var timer = 0.0

var burrow
@onready var home = $"../HomeShroom"
@onready var navmesh = $"../NavigationRegion2D"

var first = true
@onready var diffGoal = nav_agent.get_next_path_position()
@onready var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()

var roinguscircuit = load("res://Assets/SFX/roinguscircuit.wav")

func _ready() -> void:
	if (get_parent().name != "TutorialGame"):
		nav_agent.target_position = burrow.global_position

func _physics_process(_delta: float) -> void:
	if (get_parent().name != "TutorialGame"):
		
		if !nav_agent.is_navigation_finished() && !movementPaused:
			if nav_point_direction != diffGoal:
				nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
			
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
			AudioManager.play_audio_oneshot(roinguscircuit)
			Global.data["gemCount"] += 50
			
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
			position = home.global_position
		
	
