extends Node2D


func appear(audience_num, wage, balance):
	show()
	var score = audience_num * 3 + wage * 2 + balance
	$Label2.text = "Score: " + str(score) 
