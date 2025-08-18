extends CharacterBody2D


const SPEED = 300
var gravityModifier = 1;
var lvl = 1;
const LEVEL_COUNT = 2

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("reset") or position.y < -1500 or position.y > 1500:
		get_tree().reload_current_scene()
	if position.x >= 960:
		lvl += 1;
		if (lvl > LEVEL_COUNT):
			lvl = 1
			get_tree().change_scene_to_file("res://main_menu.tscn")
			print("uwu main")
		else: 	
			get_tree().change_scene_to_file("res://L" + str(lvl) + ".tscn")
			print("uwu lvl " + str(lvl))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if Input.is_action_just_pressed("flip") and (is_on_floor()):
		gravityModifier *= -1;
		velocity.y = 1000 * gravityModifier;
		rotate(deg_to_rad(180));
		up_direction *= -1;
	
	velocity += get_gravity() * delta * gravityModifier
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * gravityModifier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
