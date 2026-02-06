extends Node3D

@export var health: ProgressBar
@export var chara: CharacterBody3D
@export var rigid: RigidBody3D
@export var roll_sprite: Sprite3D
@export var shadow: RayCast3D

func _input(event):
	if event.is_action_pressed("roll"):
		if chara.visible and not chara.get_child(0).disabled:
			chara.visible = false
			chara.get_child(0).disabled = true
			rigid.get_child(0).disabled = false
			rigid.get_child(1).get_child(0).disabled = false
			rigid.freeze = false
			await get_tree().create_timer(0).timeout
			rigid.global_position = chara.global_position
			rigid.visible = true
			roll_sprite.visible = true
		elif rigid.visible and not rigid.get_child(0).disabled:
			rigid.freeze = true
			roll_sprite.visible = false
			rigid.visible = false
			rigid.get_child(0).disabled = true
			rigid.get_child(1).get_child(0).disabled = true
			chara.velocity = Vector3.ZERO
			chara.global_position = rigid.global_position
			chara.visible = true
			chara.get_child(0).disabled = false


func _on_switch_level_pressed():
	if get_parent().name == "Kitchen": get_tree().change_scene_to_file("res://Code/Levels/garden.tscn")
	elif get_parent().name == "Garden": get_tree().change_scene_to_file("res://Code/Levels/kitchen.tscn")
