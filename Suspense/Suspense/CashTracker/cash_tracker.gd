extends Node


@export var currentBalance : float = 0.00
@export var wage : float = 2.00


@onready var currentBalanceLabel = $Label
@onready var wageLabel = $Label2
@onready var timer = $Timer


var time = 20


func _on_timer_timeout():
	currentBalance += wage
	currentBalanceLabel.text = "Balance: $" + "%0.2f" % currentBalance
	timer.start(time)


func change_wage(balanceIncrease: float, wageIncrease : float):
	currentBalance += balanceIncrease
	wage += wageIncrease
	wageLabel.text = "Wage: $" + "%0.2f" % wage
	currentBalanceLabel.text = "Balance: $" + "%0.2f" % currentBalance


func change_time(new_time):
	time + new_time
