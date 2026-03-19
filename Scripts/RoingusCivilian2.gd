extends CharacterBody2D

const movement_speed = 2000.0
@onready var nav_agent : Node  = $NavigationAgent2D
var movementPaused = false
var timer = 0.0

@onready var burrow = $"../Burrow1"
@onready var goal = burrow.lowerNodes[0]
@onready var home = $"../HomeShroom"
@onready var navmesh = $"../NavigationRegion2D"
var lowestIndex = 0
signal roingusHome

var first = true
@onready var diffGoal = nav_agent.get_next_path_position()
@onready var nav_point_direction = to_local(nav_agent.get_next_path_position()).normalized()

func _ready() -> void:
	for i in range(burrow.lowerNodes.size()):
		if burrow.lowerNodes[i].distFromHome < burrow.lowerNodes[lowestIndex].distFromHome:
			lowestIndex = i
	goal = goal.lowerNodes[lowestIndex]
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
			
		elif !movementPaused:
			if goal.distFromHome == 0:
				emit_signal("roingusHome")
				Global.data["roingusCount"] += 1
				queue_free()
			else:
				
				#change goal
				lowestIndex = 0
				for i in range(goal.lowerNodes.size()):
					if goal.lowerNodes[i].distFromHome < goal.lowerNodes[lowestIndex].distFromHome:
						lowestIndex = i
				goal = goal.lowerNodes[lowestIndex]
				
				nav_agent.target_position = goal.global_position
				movementPaused = true
				await get_tree().create_timer(1).timeout
				movementPaused = false
			
		
		if !nav_agent.is_target_reachable():
			for i in range(burrow.lowerNodes.size()):
				if burrow.lowerNodes[i].distFromHome < burrow.lowerNodes[lowestIndex].distFromHome:
					lowestIndex = i
			goal = burrow.lowerNodes[lowestIndex]
			$Sprite2DFull.visible = false
			$Sprite2DEmpty.visible = true
			nav_agent.target_position = burrow.global_position
			movementPaused = false
			position = home.global_position
		
	


func _on_child_entered_tree(node: Node) -> void:
	if diffGoal:
		navmesh.bake_navigation_polygon()
	pass # Replace with function body.
