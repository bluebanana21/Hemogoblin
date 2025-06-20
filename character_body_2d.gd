extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var H_direction := Input.get_axis("left", "right")
	var V_direction := Input.get_axis("up", "down")
	
	if H_direction:
		velocity.x = H_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if  V_direction:
		velocity.y = V_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	print(velocity)
	move_and_slide()
