extends Node3D

@export var chara: CharacterBody3D
@export var rigid: RigidBody3D

func _input(event):
	if event.is_action_pressed("roll"):
		if chara.visible and not chara.get_child(0).disabled:
			chara.visible = false
			chara.get_child(0).disabled = true
			rigid.global_position = chara.global_position
			rigid.visible = true
			rigid.get_child(0).disabled = false
			rigid.freeze = false
		elif rigid.visible and not rigid.get_child(0).disabled:
			rigid.freeze = true
			rigid.visible = false
			rigid.get_child(0).disabled = true
			chara.global_position = rigid.global_position
			chara.visible = true
			chara.get_child(0).disabled = false
			
