extends Node


func _input(event):
	if event.is_action_pressed("jump_scare"):
		get_tree().change_scene_to_file("res://Opening/director_talk.tscn")
