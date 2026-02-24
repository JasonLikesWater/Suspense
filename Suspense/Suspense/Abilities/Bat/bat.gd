extends Node3D


@onready var player = get_tree().get_first_node_in_group("Players")
@onready var timer = $Timer
@onready var coolDown = $CoolDown


var bat = false


func _input(event):
	if not player.shopping:
		if Input.is_action_just_pressed("bat_toggle"):
			if bat:
				coolDown.start()
				player.speed = 7
				bat = false
				player.hidden = false
				timer.stop()
				hide()
			else:
				if coolDown.is_stopped():
					bat = true
					player.hidden = true
					player.speed = 15
					timer.start()
					show()


func _on_timer_timeout():
	player.speed = 7
	bat = false
	player.hidden = false
	coolDown.start()
	hide()


func _on_cool_down_timeout():
	pass # Replace with function body.
