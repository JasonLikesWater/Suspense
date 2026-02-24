extends HSlider


@onready var timer = $Timer
@onready var lable = $Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = 180 - timer.time_left
	lable.text = "Time\n " + "%0.0f" %timer.time_left
