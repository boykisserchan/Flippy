extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -500.0
var remainingJumps = 200


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else: 
		remainingJumps = 200

	# Handle jump.
	if (Input.is_action_just_pressed("jump") or (is_on_floor() and Input.is_action_pressed("jump"))) and remainingJumps != 0:
		velocity.y = JUMP_VELOCITY
		remainingJumps -= 1;
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
