extends CharacterBody2D

const movement_speed = 2000.0
@onready var home = get_node("../HomeShroom").global_position
@onready var goalNode = get_node("../Burrow1")
@onready var burrow = get_node("../Burrow1")
var movementPaused = false
var errorAccount = false
var timer = 0

signal roingusHome

func _ready():
	goalNode = goalNode.returnNextNode()
	$NavigationAgent2D.target_position = goalNode.global_position
	$NavigationAgent2D.get_next_path_position()
	#print($NavigationAgent2D.get_final_position(), $NavigationAgent2D.target_position)
	
	pass

func _physics_process(delta: float) -> void:
	
	if !$NavigationAgent2D.is_navigation_finished() && !movementPaused:
		velocity = ($NavigationAgent2D.get_next_path_position() - global_position).normalized() * movement_speed
		move_and_slide()
		#print('move')
		
	elif !movementPaused:
		print('arrive')
		
		if goalNode.distFromHome == 0:
			print('at home')
			emit_signal("roingusHome")
			queue_free()
		else:
			movementPaused = true
			errorAccount = false
			
			await get_tree().create_timer(0.5).timeout
			
			goalNode = goalNode.returnNextNode()
			$NavigationAgent2D.target_position = goalNode.global_position
			$NavigationAgent2D.get_next_path_position()
			movementPaused = false
	
	if !$NavigationAgent2D.is_target_reachable() && !movementPaused && errorAccount:
		print($NavigationAgent2D.get_final_position(), $NavigationAgent2D.target_position)
		$RoingusCivilian.visible = false
		movementPaused = true
		goalNode = burrow.returnNextNode()
		$NavigationAgent2D.target_position = goalNode.global_position
		$NavigationAgent2D.get_next_path_position()
		print('broken')
		
		await get_tree().create_timer(1).timeout
		position = burrow.position
		$RoingusCivilian.visible = true
		movementPaused = false
	
	if !errorAccount && $NavigationAgent2D.is_target_reachable():
		print('erroraccounted')
		errorAccount = true
