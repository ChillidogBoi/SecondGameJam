extends RigidBody3D

@export var damage: int
const ACCEL = 1.0
const MAX_SPEED = 25.0
const JUMP_VELOCITY = 4.5
const KB = 2
var cur_dir = 0

func _physics_process(delta):
	var input_dir = Input.get_axis("left", "right")
	if linear_velocity.length() > MAX_SPEED: return
	apply_central_impulse(Vector3(input_dir * ACCEL, 0, 0))
	if abs(linear_velocity.x) < 0.5: cur_dir = 0
	if cur_dir == 0: cur_dir = input_dir
	if input_dir == 0: linear_damp = 2
	elif input_dir != cur_dir and cur_dir != 0: linear_damp = 5
	else: linear_damp = 0
	print(linear_damp)


func hurt(hitter: CharacterBody3D):
	get_parent().health.value -= hitter.damage
	apply_central_impulse(hitter.global_position.direction_to(global_position) * KB)
