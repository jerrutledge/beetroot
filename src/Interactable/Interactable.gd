extends Area2D

signal on_interacted

@onready var obj_sprite = $Sprite2D
@onready var ani_player = $AnimationPlayer

@export var outline_width: int = 8

func _on_Interactable_body_entered(body):
	body._on_Interactable_enter(self)


func _on_Interactable_body_exited(body):
	body._on_Interactable_exit(self)

func highlight():
	obj_sprite.material.set_shader_parameter("width", outline_width)
	ani_player.play("pulse")
	pass
	
func unhighlight():
	obj_sprite.material.set_shader_parameter("width", 0)
	ani_player.stop(true)
	pass

func interact():
	emit_signal("on_interacted")
