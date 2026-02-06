extends RayCast3D


func _physics_process(delta):
	$Sprite3D2.global_position = get_collision_point() + (Vector3.UP * 0.001)
	$Sprite3D2.modulate = Color(1,1,1, 1 + ($Sprite3D2.position.y/6))
