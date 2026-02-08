extends Node3D


@export var started: bool = false

func _ready():
	started = true

func _process(delta):
	if get_child_count() < 1:
		get_tree().change_scene_to_file("res://Code/Levels/kitchen.tscn")
