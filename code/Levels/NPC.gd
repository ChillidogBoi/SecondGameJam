extends Sprite3D




func _input(event):
	if not $Area3D.get_overlapping_bodies().has(get_parent().player.get_parent().get_child(0)): return
	if not event.is_action_pressed("interact"): return
	if not get_parent().player.get_parent().get_child(0).is_on_floor(): return
	if $Prompt.visible:
		get_parent().player.get_parent().get_child(0).paused = true
		$Prompt.visible = false
		$Speech.visible = true
	else:
		get_parent().player.get_parent().get_child(0).paused = false
		$Prompt.visible = true
		$Speech.visible = false


func _on_area_3d_body_entered(body):
	$Prompt.visible = true
func _on_area_3d_body_exited(body):
	$Prompt.visible = false
