extends Camera3D

#how fast the camera "catches" up with the player
@export var lerp_speed = 1.5
@export var target: Node3D
#how far from the player the camera is
@export var offset = Vector3(-2, 8, 4)
#original offset =5, 12, 14

func _physics_process(delta):
	if !target:
		return
	if target.direction.z > 0:
		lerp_speed = 2
	else: 
		lerp_speed = 1.5
	#sets where the camera needs to go which is the target plus the offset
	var target_xform = target.global_transform.translated_local(offset)
	#moves the camera to where it needs to be which is the target plus the offset. It moves at the speed of lerp_speed
	global_transform = global_transform.interpolate_with(target_xform, lerp_speed * delta)
	#sets which direction the camera looks at
	look_at(target.global_transform.origin, target.transform.basis.y)
