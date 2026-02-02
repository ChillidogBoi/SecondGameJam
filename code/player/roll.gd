extends RigidBody3D


const SPEED = 0.5
const JUMP_VELOCITY = 4.5
var cur_dir = 0


func _physics_process(delta):
	var input_dir = Input.get_axis("ui_left", "ui_right")
	apply_central_impulse(Vector3(input_dir * SPEED, 0, 0))
	if abs(linear_velocity.length()) < 0.1: cur_dir = 0
	if cur_dir == 0: cur_dir = input_dir
	if input_dir == 0: linear_damp = 2
	elif input_dir != cur_dir and cur_dir != 0: linear_damp = 5
	else: linear_damp = 0
