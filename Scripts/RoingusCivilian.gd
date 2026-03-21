extends CharacterBody2D

const movement_speed = 2000.0
@onready var nav_agent : Node  = $NavigationAgent2D
var movementPaused = false
var timer = 0.0
@export var victory : AudioStream

var burrow
var goal
@onready var home = $"../HomeShroom"
@onready var navmesh = $"../NavigationRegion2D"
var lowestIndex = 0
signal roingusHome
var debugVal = 0

var first = true
@onready var diffGoal = nav_agent.get_next_path_position()
@onready var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()

var squeak = load("res://Assets/SFX/squeak.wav")

func _ready() -> void:
	#print('this')
	#print(burrow)
	#print(burrow.lowerNodes)
	for i in range(burrow.lowerNodes.size()):
		if burrow.lowerNodes[i].distFromHome < burrow.lowerNodes[lowestIndex].distFromHome:
			lowestIndex = i
	goal = burrow.lowerNodes[lowestIndex]
	if (get_parent().name != "TutorialGame"):
		nav_agent.target_position = goal.global_position

func _physics_process(delta: float) -> void:
	nav_agent.get_next_path_position()
	if (get_parent().name != "TutorialGame"):
		
		
		
		if timer >= 1:
			navmesh.bake_navigation_polygon()
			timer -=1
		else:
			timer += delta
		
		if !nav_agent.is_navigation_finished() && !movementPaused:
			if nav_point_direction != diffGoal:
				nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()
			velocity = nav_point_direction * movement_speed
			move_and_slide()
			
		elif !movementPaused && is_instance_valid(goal):
			
			if goal.distFromHome == 0:
				emit_signal("roingusHome")
				Global.data["roingusCount"] += 1
				AudioManager.play_audio_oneshot(squeak)
				if Global.data["roingusCount"] >= Global.data["winningRoinguses"]:
					print('wincon in RoingusCivilian.gd')
					
					AudioManager.stop("Game")
					AudioManager.play('Victory')
					Global.write("level", get_parent().level)
					get_tree().change_scene_to_file("res://Scenes/Levels/WinScreen.tscn")
				queue_free()
				
			else:
				
				#change goal
				lowestIndex = 0
				#print(goal)
				for i in range(goal.lowerNodes.size()):
					if goal.lowerNodes[i].distFromHome < goal.lowerNodes[lowestIndex].distFromHome:
						lowestIndex = i
						
				if goal.lowerNodes == []:
					goal = null
				else:
					goal = goal.lowerNodes[lowestIndex]
					
					nav_agent.target_position = goal.global_position
					movementPaused = true
					await get_tree().create_timer(1).timeout
					movementPaused = false
		elif !movementPaused:
			for i in range(burrow.lowerNodes.size()):
				if burrow.lowerNodes[i].distFromHome < burrow.lowerNodes[lowestIndex].distFromHome:
					lowestIndex = i
			goal = burrow.lowerNodes[lowestIndex]
			nav_agent.target_position = goal.global_position
			movementPaused = false
			position = burrow.global_position
		
		if !nav_agent.is_target_reachable():
			for i in range(burrow.lowerNodes.size()):
				if burrow.lowerNodes[i].distFromHome < burrow.lowerNodes[lowestIndex].distFromHome:
					lowestIndex = i
			goal = burrow.lowerNodes[lowestIndex]
			nav_agent.target_position = goal.global_position
			movementPaused = false
			position = burrow.global_position
		
	


func _on_child_entered_tree(node: Node) -> void:
	if diffGoal:
		navmesh.bake_navigation_polygon()
	pass # Replace with function body.
