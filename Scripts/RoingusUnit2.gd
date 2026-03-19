extends CharacterBody2D

const movement_speed = 2000.0
@onready var home = get_node("../HomeShroom").global_position
@onready var burrow = get_node("../Burrow1").global_position
@onready var navmesh = get_node("../NavigationRegion2D")
var toBurrow = true
var movementPaused = false
var errorAccount = false
var timer = 0

func _ready():
	$NavigationAgent2D.target_position = burrow
	$NavigationAgent2D.get_next_path_position()
	#print($NavigationAgent2D.get_final_position(), $NavigationAgent2D.target_position)
	pass

func _physics_process(delta: float) -> void:
	if timer >= 0.5:
		navmesh.bake_navigation_polygon()
		timer -= 0.5
	timer += delta
	
	if !$NavigationAgent2D.is_navigation_finished() && !movementPaused:
		velocity = ($NavigationAgent2D.get_next_path_position() - global_position).normalized() * movement_speed
		move_and_slide()
		#print('move')
		
	elif toBurrow && !movementPaused:
		$Sprite2DEmpty.visible = false
		toBurrow = false
		movementPaused = true
		print('burrow arrive')
		await get_tree().create_timer(1).timeout
		$Sprite2DFull.visible = true
		$NavigationAgent2D.target_position = home
		$NavigationAgent2D.get_next_path_position()
		movementPaused = false
		
	elif !toBurrow && !movementPaused:
		$Sprite2DFull.visible = false
		toBurrow = true
		Global.data["gemCount"] += 50
		movementPaused = true
		print('gems gotten')
		await get_tree().create_timer(1).timeout
		$Sprite2DEmpty.visible = true
		$NavigationAgent2D.target_position = burrow
		$NavigationAgent2D.get_next_path_position()
		movementPaused = false
	
	if !$NavigationAgent2D.is_target_reachable() && !movementPaused && errorAccount:
		print($NavigationAgent2D.get_final_position(), $NavigationAgent2D.target_position)
		$Sprite2DFull.visible = false
		$Sprite2DEmpty.visible = false
		movementPaused = true
		print('broken')
		await get_tree().create_timer(1).timeout
		position = home
		$Sprite2DEmpty.visible = true
		toBurrow = true
		$NavigationAgent2D.target_position = burrow
		$NavigationAgent2D.get_next_path_position()
		movementPaused = false
	
	if !errorAccount && $NavigationAgent2D.is_target_reachable():
		errorAccount = true
