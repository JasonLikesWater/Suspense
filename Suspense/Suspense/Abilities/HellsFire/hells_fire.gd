extends Node3D


@onready var player = get_tree().get_first_node_in_group("Players")
@onready var timer = $Timer
@onready var coolDown = $CoolDown
@onready var label = $Label


var hellsFire = false
var camera_man = null


func _input(event):
	if not player.shopping:
		if Input.is_action_just_pressed("underworld_mode") and coolDown.is_stopped() and not hellsFire:
			hellsFire = true
			player.hidden = true
			player.speed = 7
			timer.start()
			show()
		if hellsFire and Input.is_action_just_pressed("jump_scare") and camera_man != null:
			camera_man.jumpscare(true)
			hide()
			player.play_jump()


func _on_timer_timeout():
	player.speed = 7
	hellsFire = false
	player.hidden = false
	coolDown.start()
	hide()
	label.hide()


func _on_area_3d_body_entered(body):
	camera_man = body
	label.show()


func _on_area_3d_body_exited(body):
	if body == camera_man:
		camera_man = null
		label.hide()


func _on_cool_down_timeout():
	pass # Replace with function body.
