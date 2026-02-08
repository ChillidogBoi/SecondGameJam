
extends CharacterBody3D


var cur_dir = Vector2(-1, 0)
@export var health: float
@export var damage: float
@export var markers: Array[Marker3D]
@export_custom(PROPERTY_HINT_NONE, "suffix:m") var patrol_size: Vector2:
	set(v):
		patrol_size = v
		if not is_inside_tree(): return
		markers[0].position = -Vector3(patrol_size.x*2, 0, 0)
		markers[1].position = -Vector3(patrol_size.x*2, 0, patrol_size.y*2)
		markers[2].position = -Vector3(0, 0, patrol_size.y*2)
@onready var start_pos = position - Vector3(patrol_size.x, 0, patrol_size.y)
const SPEED = 3.0
const KB = 5.0
const KB_LENGTH = 10
var kb_frames: int = 0
var in_kb: bool = false

func _ready():
	$AudioStreamPlayer.volume_linear = settings.sfx_vol

func _physics_process(delta):
	if not get_parent().has_signal("visibility_changed"): return
	if get_parent().started == false: return
	
	if in_kb:
		kb_frames += 1
		if not is_on_floor():
			velocity += get_gravity() * delta
		move_and_slide()
		if kb_frames > KB_LENGTH:
			in_kb = false
			kb_frames = 0
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	if cur_dir.y == 0 and patrol_size.x < abs(position.x - start_pos.x):
		cur_dir = Vector2(cur_dir.y, cur_dir.x)
	elif cur_dir.x == 0 and patrol_size.y < abs(position.z - start_pos.z):
		cur_dir = Vector2(-cur_dir.y, -cur_dir.x)
	velocity = Vector3(cur_dir.x * SPEED, velocity.y, cur_dir.y * SPEED)
	move_and_slide()


func _on_area_3d_body_entered(body):
	body.hurt(self)

func _on_area_3d_area_entered(area):
	health -= area.get_parent().damage
	if health <= 0:
		$Sprite3D2.visible = true
		$Sprite3D2.reparent(get_parent().get_parent())
		$AudioStreamPlayer.play()
		queue_free()
		return
	velocity = area.global_position.direction_to(global_position) * KB
	velocity.y = 3.5
	in_kb = true


func _on_player_sfx_changed():
	$AudioStreamPlayer.volume_linear = settings.sfx_vol
