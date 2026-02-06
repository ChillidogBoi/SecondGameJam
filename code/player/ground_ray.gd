extends RayCast3D


var move_y: bool = false

func _physics_process(delta):
	if get_parent().rigid.visible: global_position = get_parent().rigid.global_position
	elif get_parent().chara.visible: global_position = get_parent().chara.global_position
	if not is_colliding(): return
	$Sprite3D2.global_position = get_collision_point() + (Vector3.UP * 0.001)
	$Sprite3D2.modulate = Color(1,1,1, 1 + ($Sprite3D2.position.y/6))

func _process(delta):
	$Sprite3D2/Camera3D.global_position.x = global_position.x
	if not move_y: return
	$Sprite3D2/Camera3D.global_position.y = global_position.y
