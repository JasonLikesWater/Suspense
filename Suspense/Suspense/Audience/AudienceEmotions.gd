extends Node
class_name emotionControl


@export var current_emotion = emotions.INTERESTED
@export var audience_num = 8


@onready var emotion_check_timer = $EmotionCheck
@onready var audience_emotion_label = $Control/VBoxContainer/AudienceEmotion
@onready var audience_size_label = $Control/VBoxContainer/AudienceSize
@onready var audience_timer = $AudienceAddTimer
@onready var add_thought_timer = $AddThoughtTimer
@onready var dialogue = $Control/Dialogue
@onready var animation = $AnimationPlayer


enum emotions{
	BORED,
	INTERESTED,
	DISAPPOINTED,
	SCARED,
	SUSPENSFUL,
	INVESTED
}


var dialogues = []
var emotional_num = 3
var current_emotion_text = "Interested"
var expecting = ""
var demon_thoughts = ["Look at that demonic imagery.", "Sell your soul.", "Drag him to Hell.", "I'm terrified of demons."]
var beast_thoughts = ["I hope the monster has huge fangs.", "Did you see those claw marks?", "I bet the monster is a mutated beast."]
var ghost_thoughts = ["Was that guy possesed?", "Can the monster walk through walls.", "Did the table just move on its own?"]
var bored_thought = ["God will something happen?", "I'm so bored.", "Zzzzzz...", "I'm leaving.", "Where is the monster?", "I couldn't care less.", "Waste of 2 hours.", "Kinda wishing I stayed home today.", "Bruh, will anything happen soon?"]
var interested_thought = ["Decent movie.", "Solid movie so far.", "I hope this movie does well.", "Woooo! keep up the pace.", "This is an alright movie.", "I'd watch this again.", "Great movie, unless your sober."]
var disappointed_thought = ["I thought my friends told me this movie was good?", "This sucks.", "Why did nothing happen.", "I'd rather be doing literally anything right now.", "I'm leaving now.", "0/10 bye.", "This is so bad"]
var scared_thought = ["This is great.", "Did you see that? I think it was the monster.", "That jumpscare really got me.", "This movie is awesome.", "This movie is better than expected.", "I'm shaking right now.", "AAAAAAAAAAAAA!", "F$%@#!"]
var suspenseful_thought = ["I bet something is about to happen.", "I don't know if I'm ready for this.", "Oh my God!", "I bet a jumpscare is about to happen.", "I'm on the edge of my seat.", "What is gonna happen next?"]
var invested_thought = ["This movie is awesome!", "I hope this movie gets a sequel.", "RUN Amy!", "This movie is gonna make it big.", "Modern Masterpiece.", "Lowkey movie of the year.", "I wanna watch this again."]
var random_thought = ["Time to make out.", "This popcorn is really good.", "I should have gotten a bigger drink.", "I need to pee.", "Ever think about ducks?", "Did I turn off the stove?", "This movie needed a bigger budget.", "I wonder how critics like this movie.", "Shut up Tom!"]

func _ready():
	var list = ["Ghost", "Demon", "Beast"]
	expecting = list[randi_range(0, 2)]
	audience_timer.start(randi_range(4, 8))
	add_thought_timer.start(randi_range(4, 8))
	dialogues = dialogue.get_children()
	


func add_audience():
	match current_emotion:
		emotions.BORED:
			audience_num -= 2
		emotions.INTERESTED:
			audience_num += 2
		emotions.DISAPPOINTED:
			audience_num -= 4
		emotions.SCARED:
			audience_num += 6
		emotions.SUSPENSFUL:
			audience_num += 1
		emotions.INVESTED:
			audience_num += 4
	audience_timer.start(randi_range(4, 8))
	audience_size_label.text = "Audience Size:" + "\n" + str(audience_num)



func _on_emotion_check_timeout():
	emotional_num -= 1
	if emotional_num <= 0:
		match current_emotion:
			emotions.BORED:
				change_emotion(0)
			emotions.INTERESTED:
				change_emotion(0)
			emotions.DISAPPOINTED:
				change_emotion(0)
			emotions.SCARED:
				change_emotion(5)
			emotions.SUSPENSFUL:
				change_emotion(2)
			emotions.INVESTED:
				change_emotion(1)


func change_emotion(new_emotion : int):
	match new_emotion:
		0:
			current_emotion = emotions.BORED
			emotional_num = 0
		1:
			current_emotion = emotions.INTERESTED
			emotional_num = 2
		2:
			current_emotion = emotions.DISAPPOINTED
			emotional_num = 2
		3:
			current_emotion = emotions.SCARED
			emotional_num = 1
		4:
			current_emotion = emotions.SUSPENSFUL
			emotional_num = 1
		5:
			current_emotion = emotions.INVESTED
			emotional_num = 2
	change_emotion_label(current_emotion)


func change_emotion_label(new_emotion):
	var rand_text = randi_range(0, 2)
	match new_emotion:
		0:
			if rand_text == 0:
				current_emotion_text = "Bored"
			elif  rand_text == 1:
				current_emotion_text = "Lame"
			else:
				current_emotion_text = "Uninterested"
		1:
			if rand_text == 0:
				current_emotion_text = "Interested"
			elif  rand_text == 1:
				current_emotion_text = "Excited"
			else:
				current_emotion_text = "Intrigued"
		2:
			if rand_text == 0:
				current_emotion_text = "Disappointed"
			elif  rand_text == 1:
				current_emotion_text = "Complaining"
			else:
				current_emotion_text = "Frustrated"
		3:
			if rand_text == 0:
				current_emotion_text = "Scared"
			elif  rand_text == 1:
				current_emotion_text = "Terrified"
			else:
				current_emotion_text = "Startled"
		4:
			if rand_text == 0:
				current_emotion_text = "Suspensful"
			elif  rand_text == 1:
				current_emotion_text = "Anticipating"
			else:
				current_emotion_text = "Expecting"
		5:
			if rand_text == 0:
				current_emotion_text = "Invested"
			elif  rand_text == 1:
				current_emotion_text = "Captivated"
			else:
				current_emotion_text = "Enjoying"
	audience_emotion_label.text = current_emotion_text


func _on_shop_interface_player_appearance(appearance):
	if appearance == expecting:
		audience_num += 2
		if current_emotion == emotions.INVESTED:
			change_emotion(3)
		elif current_emotion == emotions.SCARED:
			pass
		else:
			change_emotion(1)
	audience_num += 2


func weighted_emotion_change(new_emotion):
	match current_emotion:
		emotions.BORED:
			change_emotion(new_emotion)
		emotions.INTERESTED:
			audience_num += 2
		emotions.DISAPPOINTED:
			audience_num -= 4
		emotions.SCARED:
			audience_num += 6
		emotions.SUSPENSFUL:
			audience_num += 1
		emotions.INVESTED:
			audience_num += 4


func _on_add_thought_timer_timeout():
	animation.play("new_thought")
	add_thought_timer.start(randi_range(7, 13))
	var thoughts = []
	if expecting == "Ghost":
		thoughts.append_array(ghost_thoughts)
	elif expecting == "Demon":
		thoughts.append_array(demon_thoughts)
	else: 
		thoughts.append_array(beast_thoughts)
	
	thoughts.append_array(random_thought)
	
	match current_emotion:
		emotions.BORED:
			thoughts.append_array(bored_thought)
		emotions.INTERESTED:
			thoughts.append_array(interested_thought)
		emotions.DISAPPOINTED:
			thoughts.append_array(disappointed_thought)
		emotions.SCARED:
			thoughts.append_array(scared_thought)
		emotions.SUSPENSFUL:
			thoughts.append_array(suspenseful_thought)
		emotions.INVESTED:
			thoughts.append_array(invested_thought)
	dialogues[4].text = thoughts[randi_range(0, thoughts.size() - 1)]



func _on_animation_player_animation_finished(anim_name):
	if anim_name == "new_thought":
		dialogues[1].position = Vector2.ZERO
		dialogues[2].position.y = 42
		dialogues[3].position.y = 85
		dialogues[4].position.y = 130
		dialogues[1].text = dialogues[2].text
		dialogues[2].text = dialogues[3].text
		dialogues[3].text = dialogues[4].text


func _on_shop_interface_add_audience(people):
	audience_num += people
