extends Node3D


func _ready():
	$AudioStreamPlayer.volume_linear = settings.music_vol
