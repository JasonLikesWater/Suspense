extends Node


@onready var text_box = $Label


var dialogue = 0


"
You won't be doing it for free however, In the top left you will see your BALANCE AND WAGE.
Every TWENTY SECONDS I'll pay you your wage. If you get enough money you can buy upgrades from the shop to make a better movie.
Remember this movie is only THREE MINUTES long so you better PACE YOURSELF. Nobody likes a movie where EVERYTHING INTERESTING HAPPENS AT THE END, nor do they like
it if it all HAPPENS AT THE BEGINNING. Oh and by the way Doug didn't do his job so there is a lot of CAMERA EQUIPMENT LYING AROUND. Can you pick them up for me?
In fact I just fired Doug so if you do pick up equipment, I'll INCREASE YOUR PAY. Got it you're the best now get out their and make the best movie ever. Press [Space] To Start."

func _input(event):
	if Input.is_action_just_pressed("move_left"):
		dialogue -= 1
	if Input.is_action_just_pressed("move_right"):
		dialogue += 1
	dialogue = clamp(dialogue, 0, 9)
	if Input.is_action_just_pressed("jump_scare"):
		get_tree().change_scene_to_file("res://Level/world.tscn")
	
	
	match dialogue:
		0:
			text_box.text = "      Hey you must be the new monster! Boy do we need you; test screenings have not gone well so far. Listen, we need to make this movie a hit so I'm going to give you complete creative freedom for how the plot goes."
		1:
			text_box.text =  "      You are the monster and there will be FIVE CAMERA MEN on set. Your job is to make the live AUDIENCE HAPPY AND INVESTED. The best way to do that is to SNEAK UP behind the cameramen and JUMPSCARE them."
		2:
			text_box.text = "      You won't be doing it for free; however, in the top right you will see your BALANCE and WAGE. Every TWENTY SECONDS I'll pay you your wage."
		3:
			text_box.text = "      If you get enough money you can BUY UPGRADES from the shop to make a better movie."
		4:
			text_box.text = "      Remeber this movie is only THREE MINUTES long, so you'd better PACE YOURSELF."
		5:
			text_box.text = "      Nobody likes a movie where everything interesting happens AT THE END, nor do they like it all to happen AT THE BEGINNING."
		6:
			text_box.text = "      Oh and by the way, Doug didn't do his job so there is a bunch of CAMERA EQUIPMENT LYING AROUND set. Can you pick them up for me?"
		7:
			text_box.text = "      In fact, I just fired Doug so if you do his job for him, I'll INCREASE YOUR PAY!"
		8:
			text_box.text = "      But remember your goal isn't to make money it is to GET AS MANY AUDIENCE MEMBERS INVESTED as possible."
		9:
			text_box.text = "      Got it? Now get out there and make the best movie ever! \nPress [Space] To Start"
