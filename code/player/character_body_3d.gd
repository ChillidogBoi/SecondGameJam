extends CharacterBody3D


const SPEED = 9.5
const JUMP_VELOCITY = 20.0
const KB = 25.0
const KB_LENGTH = 10
var kb_frames: int = 0
var in_kb: bool = false



func hurt(hitter: CharacterBody3D):
	get_parent().health.value -= hitter.damage
	velocity = hitter.global_position.direction_to(global_position) * KB
	velocity.y = 3.5
	in_kb = true


func _physics_process(delta):
	if in_kb:
		kb_frames += 1
		move_and_slide()
		if kb_frames > KB_LENGTH:
			in_kb = false
			kb_frames = 0
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 5

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
