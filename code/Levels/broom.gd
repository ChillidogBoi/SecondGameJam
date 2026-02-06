extends Node3D


var moved = false


func _on_area_3d_body_entered(body):
	if moved: return
	if not body.name == "Rigid": return
	moved = true
	$AnimationPlayer.play("fall")
	body.get_parent().shadow.move_y = true
