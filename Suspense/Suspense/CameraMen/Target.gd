extends Node3D


@export var minRange = Vector2(0,0)
@export var maxRange = Vector2(0,0)


func _on_area_3d_body_entered(body):
	position.x = randf_range(minRange.x, maxRange.x)
	position.z = randf_range(minRange.y, maxRange.y)


func _on_camera_man_target_relocate(location):
	if location != Vector3.ZERO:
		position = location
	else:
		position.x = randf_range(minRange.x, maxRange.x)
		position.z = randf_range(minRange.y, maxRange.y)
