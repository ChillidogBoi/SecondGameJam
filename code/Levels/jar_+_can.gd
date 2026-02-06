extends Node3D


var moved: bool = false


func _on_area_3d_body_entered(body):
	if moved: return
	if not body.name == "Rigid": return
	moved = true
	$AnimationPlayer.play("fall")
	await $AnimationPlayer.animation_finished
	$"Jar Full".queue_free()
	
