extends RayCast3D


func _physics_process(delta):
	if not is_colliding(): return
	$"../Sprite3D2".global_position = get_collision_point() + (Vector3.UP * 0.001)
