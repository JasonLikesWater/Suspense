extends Control

signal playerMovement(boolean)
signal playerAppearance(appearance)
signal shopping(boolean)
signal addAudience(people)


@export var cash_tracker : Node = null


@onready var player = get_tree().get_first_node_in_group("Players")
@onready var helpLabel = $HelpLabel
@onready var shopContainer = $Shop
@onready var makeupContainer = $Makeup
@onready var specialEffectsContainer = $SpecialEffects
@onready var marketingContainer = $Marketing


var appearanceChosen = false
var pause = false

#Ghost, demon, beast, bat, hells, roar
var bought = [false, false, false, false, false, false]


func _input(event):
	if event.is_action_pressed("pause"):
		if pause:
			pause = false
			makeupContainer.hide()
			shopContainer.hide()
			marketingContainer.hide()
			specialEffectsContainer.hide()
			playerMovement.emit(true)
			shopping.emit(false)
			helpLabel.hide()
		else:
			helpLabel.text = ""
			pause = true
			makeupContainer.hide()
			shopContainer.show()
			marketingContainer.hide()
			specialEffectsContainer.hide()
			playerMovement.emit(false)
			shopping.emit(true)
			helpLabel.show()
		


func _on_makeup_button_pressed():
	makeupContainer.show()
	shopContainer.hide()


func _on_makeup_button_mouse_entered():
	helpLabel.text = "Style Yourself To Fit The Movie Theme"


func _on_special_effects_button_pressed():
	specialEffectsContainer.show()
	shopContainer.hide()


func _on_special_effects_button_mouse_entered():
	helpLabel.text = "Gain New Abilites With Better Special Effects"


func _on_marketing_button_mouse_entered():
	helpLabel.text = "Increase Money By Marketing Your Movie"


func _on_marketing_button_pressed():
	marketingContainer.show()
	shopContainer.hide()


func _on_vampire_pressed():
	if cash_tracker.currentBalance >= 25:
		cash_tracker.change_wage(-25, 0)
		if not bought[0]:
			makeupContainer.hide()
			playerMovement.emit(true)
			shopping.emit(false)
			helpLabel.hide()
			if not (bought[0] or bought[1] or bought[2]):
				give_ghost()
			bought[0] = true
			playerAppearance.emit("Ghost")


func _on_vampire_mouse_entered():
	if not (bought[0] or bought[1] or bought[2]):
		helpLabel.text = "Become A Ghost \nFirst Bonus: Gain Ghost Morph Ability"
	else:
		helpLabel.text = "Become A Ghost"


func _on_demon_pressed():
	if cash_tracker.currentBalance >= 30:
		cash_tracker.change_wage(-30, 0)
		if not bought[1]:
			makeupContainer.hide()
			playerMovement.emit(true)
			shopping.emit(false)
			helpLabel.hide()
			if not (bought[0] or bought[1] or bought[2]):
				give_hells_fire()
			bought[1] = true
			playerAppearance.emit("Demon")


func _on_demon_mouse_entered():
	if not (bought[0] or bought[1] or bought[2]):
		helpLabel.text = "Sell Your Soul \nFirst Bonus: Gain Hell's Fire Ability"
	else:
		helpLabel.text = "Sell Your Soul"


func _on_beast_pressed():
	if cash_tracker.currentBalance >= 35:
		cash_tracker.change_wage(-35, 0)
		if not bought[2]:
			makeupContainer.hide()
			playerMovement.emit(true)
			shopping.emit(false)
			helpLabel.hide()
			if not (bought[0] or bought[1] or bought[2]):
				give_roar()
			bought[2] = true
			playerAppearance.emit("Beast")


func _on_beast_mouse_entered():
	if not (bought[0] or bought[1] or bought[2]):
		helpLabel.text = "Mutate Your Body \nFirst Bonus: Gain A Visceral Roar Ability"
	else:
		helpLabel.text = "Mutate Your Body"


func give_ghost():
	if not bought[3]:
		var bat = load("res://Abilities/Bat/bat.tscn").instantiate()
		player.add_child(bat)
		bought[3] = true
	


func _on_bat_transformation_pressed():
	if cash_tracker.currentBalance >= 20:
		cash_tracker.change_wage(-20, 0)
		if not bought[3]:
			specialEffectsContainer.hide()
			playerMovement.emit(true)
			shopping.emit(false)
			helpLabel.hide()
			give_ghost()


func _on_bat_transformation_mouse_entered():
	helpLabel.text = "Transform Into An Agile Spirit To Aid Your Mobility \nWith [Right Click]"


func _on_hells_fire_pressed():
	if cash_tracker.currentBalance >= 18:
		cash_tracker.change_wage(-18, 0)
		if not bought[4]:
			specialEffectsContainer.hide()
			playerMovement.emit(true)
			shopping.emit(false)
			helpLabel.hide()
			give_hells_fire()


func give_hells_fire():
	if not bought[4]:
		var fire = load("res://Abilities/HellsFire/hells_fire.tscn").instantiate()
		player.add_child(fire)
		bought[4] = true
	


func _on_hells_fire_mouse_entered():
	helpLabel.text = "Ambush Your Prey By Dragging Them Into Hell \n With [F]"


func _on_visceral_roar_pressed():
	if cash_tracker.currentBalance >= 25:
		cash_tracker.change_wage(-25, 0)
		if not bought[5]:
			specialEffectsContainer.hide()
			playerMovement.emit(true)
			shopping.emit(false)
			helpLabel.hide()
			give_roar()


func give_roar():
	if not bought[5]:
		var roar = load("res://Abilities/Roar/roar.tscn").instantiate()
		player.add_child(roar)
		bought[5] = true


func _on_visceral_roar_mouse_entered():
	helpLabel.text = "Stun Nearby Enemies Leaves Your Audience On \n The Edge of Their Seats With [R]"


func _on_play_an_ad_pressed():
	if cash_tracker.currentBalance >= 20:
		cash_tracker.change_wage(-20, 0)
		marketingContainer.hide()
		playerMovement.emit(true)
		shopping.emit(false)
		helpLabel.hide()
		cash_tracker.change_wage(0, 2)
		addAudience.emit(-5)


func _on_play_an_ad_mouse_entered():
	helpLabel.text = "Increase Your Wage, But Your Audience Might Not Like It"


func _on_social_media_campaign_pressed():
	if cash_tracker.currentBalance >= 15:
		cash_tracker.change_wage(-15, 0)
		marketingContainer.hide()
		playerMovement.emit(true)
		shopping.emit(false)
		helpLabel.hide()
		addAudience.emit(8)


func _on_social_media_campaign_mouse_entered():
	helpLabel.text = "Increase The Amount of Audience Members Through Social Media Ads"


func _on_time_pressed():
	if cash_tracker.currentBalance >= 20:
		cash_tracker.change_wage(-20, 0)
		marketingContainer.hide()
		playerMovement.emit(true)
		shopping.emit(false)
		helpLabel.hide()
		cash_tracker.change_time(-2)


func _on_time_mouse_entered():
	helpLabel.text = "New Movie Trailler Decreases The Time For You to Be Paid Your Wage"


func _on_exit_pressed():
	shopContainer.hide()
	playerMovement.emit(true)
	shopping.emit(false)
	helpLabel.hide()


func _on_back_button_pressed():
	shopContainer.show()
	makeupContainer.hide()
	specialEffectsContainer.hide()
	marketingContainer.hide()
