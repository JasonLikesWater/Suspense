extends Area3D
class_name InteractionArea


signal addCash(money, wage)


@export var action_name: String = "Interact"
@export var money : float = 0.00
@export var wage_change : float = 0.00


var interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self, body)


func _on_body_exited(body):
	InteractionManager.unregister_area(self, body)


func pick_up():
	addCash.emit(money, wage_change)
