extends Node3D


@export var player: RayCast3D
@export var faces: Array[Sprite3D]
var face_starts: Array[Vector3]


func _ready():
	for n in faces:
		face_starts.append(n.position)

func _process(delta):
	for n:int in faces.size():
		if player.global_position.distance_to(faces[n].global_position) < 25:
			faces[n].position = face_starts[n] + (faces[n].global_position.direction_to(player.global_position)/2)
