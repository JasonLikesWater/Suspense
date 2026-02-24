extends CharacterBody3D


signal add_cash(money, wage)


@onready var interaction = $InteractionArea


@export var balance = 0
@export var wage = 0


func _ready():
	interaction.money = balance
	interaction.wage_change = wage

func _on_interaction_area_add_cash(money, wage):
	add_cash.emit(money, wage)
	queue_free()
