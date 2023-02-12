extends Area2D

@export var spring_power: int = 500

func _on_Trampoline_body_entered(body):
	if body.has_method("_on_Trampoline"):
		body._on_Trampoline(spring_power)
