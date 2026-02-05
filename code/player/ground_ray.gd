extends RayCast3D


func _physics_process(delta):
	if Input.is_action_pressed("left"):
		if $Sprite3D2/Camera3D.position.x > -7: $Sprite3D2/Camera3D.position.x -= delta * 4
	elif Input.is_action_pressed("right"):
		if $Sprite3D2/Camera3D.position.x < 7: $Sprite3D2/Camera3D.position.x += delta * 4
	elif $Sprite3D2/Camera3D.position.x > 0.1: $Sprite3D2/Camera3D.position.x -= delta * 4
	elif $Sprite3D2/Camera3D.position.x < -0.1: $Sprite3D2/Camera3D.position.x += delta * 4
	if get_parent().rigid.visible: global_position = get_parent().rigid.global_position
	elif get_parent().chara.visible: global_position = get_parent().chara.global_position
	if not is_colliding(): return
	$Sprite3D2.global_position = get_collision_point() + (Vector3.UP * 0.001)
	$Sprite3D2.modulate = Color(1,1,1, 1 + ($Sprite3D2.position.y/6))
