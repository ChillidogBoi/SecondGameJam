extends Node3D


var moved: bool = false

func _ready():
	$AudioStreamPlayer2.volume_linear = settings.sfx_vol

func _on_area_3d_body_entered(body):
	if moved: return
	if not body.name == "Rigid": return
	moved = true
	$AnimationPlayer.play("fall")
	await $AnimationPlayer.animation_finished
	$"Jar Full".queue_free()


func _on_player_sfx_changed():
	pass # Replace with function body.
