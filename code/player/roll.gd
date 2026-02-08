extends RigidBody3D

@export var damage: int
const ACCEL = 1.0
const MAX_SPEED = 25.0
const JUMP_VELOCITY = 4.5
const KB = 2
var cur_dir = 0
var flip_bit: bool = false
var wall: bool = false

const BONKS = [
	preload("res://Music/sfx/bonk_01.mp3"),
	preload("res://Music/sfx/bonk_02.mp3"),
	preload("res://Music/sfx/bonk_03.mp3")
]
const CLINK_01 = preload("uid://8au2dp603u4c")


func _physics_process(delta):
	var input_dir = Input.get_axis("left", "right")
	
	if get_colliding_bodies().size() > 1:
		if not wall:
			wall = true
			if get_colliding_bodies().has($"../../Objects/Jar + Can/Jar Full/CSGBox3D"):
				$"../AudioStreamPlayer3".stream = CLINK_01
			else: $"../AudioStreamPlayer3".stream = BONKS[randi_range(0,2)]
			$"../AudioStreamPlayer3".play()
	else: wall = false
	if abs(linear_velocity.x) > 0.1 and not freeze:
		if not $"../AudioStreamPlayer".playing: $"../AudioStreamPlayer".play()
	else: $"../AudioStreamPlayer".stop()
	if linear_velocity.length() > MAX_SPEED: return
	apply_central_impulse(Vector3(input_dir * ACCEL, 0, 0))
	if abs(linear_velocity.x) < 0.5: cur_dir = 0
	if cur_dir == 0: cur_dir = input_dir
	if input_dir == 0: linear_damp = 2
	elif input_dir != cur_dir and cur_dir != 0: linear_damp = 5
	else: linear_damp = 0

func _process(delta):
	if not visible: return
	if flip_bit:
		flip_bit = false
		return
	flip_bit = true
	$"../ground/roll_sprite/AnimationPlayer".stop(true)
	$"../ground/roll_sprite/AnimationPlayer".play("roll")
	$"../ground/roll_sprite/AnimationPlayer".seek((-rotation.z + (PI))/2)

func hurt(hitter: CharacterBody3D):
	get_parent().health.value -= hitter.damage
	apply_central_impulse(hitter.global_position.direction_to(global_position) * KB)
