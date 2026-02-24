extends Node


@onready var player = null
@onready var label = $Label


const BASE_TEXT = "[Click] to Pickup "


var active_areas = []


func register_area(area: InteractionArea, player_node):	
	active_areas.push_back(area)


func unregister_area(area: InteractionArea, player_node):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)


func _process(_delta):
	if active_areas.size() > 0:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = BASE_TEXT + active_areas[0].action_name
		#label.global_position.y -= 36
		#label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()


func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player


func _unhandled_input(event):
	if event.is_action_pressed("pick_up"):
		if active_areas.size() > 0:
			label.hide()
			active_areas[0].pick_up()
