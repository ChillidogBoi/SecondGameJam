extends Node3D


@export var started: bool = false
var moving

func _ready():
	started = true

func _process(delta):
	if get_child_count() < 1:
		await get_tree().create_timer(0.1).timeout
		$"../ColorRect".visible = true
		get_tree().change_scene_to_file("res://Code/Levels/kitchen.tscn")
