extends Area3D



func _on_body_entered(body):
	print(body.get_parent().shadow.get_child(0).get_child(0).position.z)
	while overlaps_body(body) and body.get_parent().shadow.get_child(0).get_child(0).position.z > 5:
		body.get_parent().shadow.get_child(0).get_child(0).position.z -= 0.5
		await get_tree().create_timer(0).timeout
func _on_body_exited(body):
	while not overlaps_body(body) and body.get_parent().shadow.get_child(0).get_child(0).position.z < 20:
		body.get_parent().shadow.get_child(0).get_child(0).position.z += 0.5
		await get_tree().create_timer(0).timeout
	
