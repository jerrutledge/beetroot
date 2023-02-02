extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var near_guy = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Speech.visible = false



func _process(delta):
	if Input.is_action_pressed("ui_select"):
		if near_guy == true:
			$Speech.visible = true	
		



func _on_Player_near_guy():
	near_guy = true



func _on_Player_not_near_guy():
	near_guy = false
