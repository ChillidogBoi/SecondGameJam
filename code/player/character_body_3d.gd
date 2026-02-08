extends CharacterBody3D


const SPEED = 12.5
const JUMP_VELOCITY = 20.0
const KB = 25.0
const KB_LENGTH = 10
var kb_frames: int = 0
var in_kb: bool = false
var paused: bool = false

const STEPS = [
	preload("uid://4chcgtie7qfp"),
	preload("uid://de654b460nsuj"),
	preload("uid://bpcido40cfvq8")
]



func _ready():
	$"../ground/roll_sprite/AnimationPlayer".play("idle")


func hurt(hitter: CharacterBody3D):
	if paused: return
	get_parent().health.value -= hitter.damage
	velocity = hitter.global_position.direction_to(global_position) * KB
	velocity.y = 3.5
	in_kb = true
	if get_parent().health.value <= 0:
		paused = true
		$"../../ColorRect2".visible = true

func _physics_process(delta):
	if not visible: return
	if Input.is_action_just_pressed("pause"):
		if $"../UI/Menu".visible:
			paused = false
			$"../UI/Menu".visible = false
		else:
			paused = true
			$"../UI/Menu".visible = true
	
	if paused: return
	
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
		if $"../AudioStreamPlayer2".stream == null: _on_audio_stream_player_2_finished()
		if direction.x < 0: $Sprite3D.flip_h = true
		elif $Sprite3D.flip_h: $Sprite3D.flip_h = false
		$"../ground/roll_sprite/AnimationPlayer".play("walk")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		$"../ground/roll_sprite/AnimationPlayer".play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_audio_stream_player_2_finished():
	if abs(velocity.x) + abs(velocity.z) > 0:
		$"../AudioStreamPlayer2".stream = STEPS[randi_range(0,2)]
		$"../AudioStreamPlayer2".play()
	else: $"../AudioStreamPlayer2".stream = null
