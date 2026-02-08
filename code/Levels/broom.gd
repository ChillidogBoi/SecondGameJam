extends Node3D


var moved = false

func _ready():
	$AudioStreamPlayer2.volume_linear = settings.sfx_vol
	$AudioStreamPlayer3.volume_linear = settings.sfx_vol

func _on_area_3d_body_entered(body):
	if moved: return
	if not body.name == "Rigid": return
	moved = true
	$AnimationPlayer.play("fall")
	body.get_parent().shadow.move_y = true


func _on_player_sfx_changed():
	_ready()
