extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$Ending.appear($AudienceEmotions.audience_num, $CashTracker.wage, $CashTracker.currentBalance)
	Engine.time_scale = 0
