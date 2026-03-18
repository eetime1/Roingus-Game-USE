extends CharacterBody2D


const SPEED = 600.0
const MouseSpeed = 1
const zoomFactor = 0.01
var isPressed = false
var lastMouseX
var lastMouseY

func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionLR := Input.get_axis("left", "right")
	print(directionLR)
	if directionLR:
		velocity.x = directionLR * SPEED  / $Camera2D.zoom.x
		if Input.is_action_pressed("shift") :
			velocity.x *= 3
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var directionUD := Input.get_axis("up", "down")
	if directionUD:
		velocity.y = directionUD * SPEED  / $Camera2D.zoom.y
		if Input.is_action_pressed("shift") :
			velocity.y *= 3
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	move_and_slide()
	if directionLR == 0:
		velocity.x = 0
	if directionUD == 0:
		velocity.y = 0

func _input(event):
	
	if event is InputEventMouseButton:
		
		if event.button_index == 3 && event.pressed:
			isPressed = true
			lastMouseX = event.position.x
			lastMouseY = event.position.y
			
		elif event.button_index == 3 && !event.pressed :
			isPressed = false
			
		
		if event.button_index == 4:
			$Camera2D.zoom.x += zoomFactor
			$Camera2D.zoom.y += zoomFactor
		elif event.button_index == 5:
			$Camera2D.zoom.x -= zoomFactor
			$Camera2D.zoom.y -= zoomFactor
		
	
	if event is InputEventMouseMotion && isPressed:
		position.x += (lastMouseX - event.position.x) * MouseSpeed / $Camera2D.zoom.x
		position.y += (lastMouseY - event.position.y) * MouseSpeed / $Camera2D.zoom.y
		print(position)
		lastMouseX = event.position.x
		lastMouseY = event.position.y
