extends CharacterBody2D

const SPEED = 600.0
const MouseSpeed = 1
const zoomFactor = 0.005
const zoomMin = 0.15
const zoomMax = 0.05
var isPressed = false
var lastMouseX
var lastMouseY
var camEdgesX = [-9999999, 9999999]
var camEdgesY = [-9999999, 9999999]
var timer = 0
@onready var navmesh = $"../Level/NavigationRegion2D"

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# *I'm going to cry*
	Global.globalPosition = global_position

	var directionLR := Input.get_axis("left", "right")
	if directionLR:
		velocity.x = directionLR * SPEED  / $Camera2D.zoom.x
		if Input.is_action_pressed("shift") :
			velocity.x *= 3
	else:
		velocity.x = move_toward(0, 0, SPEED)
	
	var directionUD := Input.get_axis("up", "down")
	if directionUD:
		velocity.y = directionUD * SPEED  / $Camera2D.zoom.y
		if Input.is_action_pressed("shift"):
			velocity.y *= 3
	else:
		velocity.y = move_toward(0, 0, SPEED)

	if (global_position.x < camEdgesX[0] && directionLR < 0) || (global_position.x > camEdgesX[1] && directionLR > 0):
		velocity.x = 0	
	if (global_position.y < camEdgesY[0] && directionUD < 0) || (global_position.y > camEdgesY[1] && directionUD > 0):
		velocity.y = 0
		
	move_and_slide()	
	
	if timer >= 1:
		navmesh.bake_navigation_polygon()
		timer -= 1
	else:
		timer += delta
	

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 3 && event.pressed:
			isPressed = true
			lastMouseX = event.position.x
			lastMouseY = event.position.y
			
		elif event.button_index == 3 && !event.pressed :
			isPressed = false
			
		if event.button_index == 4 && $Camera2D.zoom.x < zoomMin:
			$Camera2D.zoom.x += zoomFactor
			$Camera2D.zoom.y += zoomFactor
		elif event.button_index == 5 && $Camera2D.zoom.x > zoomMax:
			$Camera2D.zoom.x -= zoomFactor
			$Camera2D.zoom.y -= zoomFactor
	
	if event is InputEventMouseMotion && isPressed:
		var posXAdd = (lastMouseX - event.position.x) * MouseSpeed / $Camera2D.zoom.x
		var posYAdd = (lastMouseY - event.position.y) * MouseSpeed / $Camera2D.zoom.y
		
		if position.x + posXAdd > camEdgesX[0] && position.x + posXAdd < camEdgesX[1]:
			position.x += posXAdd
		if position.y + posYAdd > camEdgesY[0] && position.y + posYAdd < camEdgesY[1]:
			position.y += posYAdd
			
		lastMouseX = event.position.x
		lastMouseY = event.position.y
