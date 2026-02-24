extends Node3D


@onready var player = get_tree().get_first_node_in_group("Players")
@onready var coolDown = $CoolDown


var bodies_inside = []


func _input(event):
	if not player.shopping:
		if Input.is_action_just_pressed("roar") and coolDown.is_stopped():
			coolDown.start()
			$AudioStreamPlayer.play(.4)
			for x in bodies_inside:
				if x != null:
					x.stun()


func _on_area_3d_body_entered(body):
	bodies_inside.append(body)


func _on_area_3d_body_exited(body):
	for x in bodies_inside:
		if x == body:
			bodies_inside.erase(x)
	print(bodies_inside)
