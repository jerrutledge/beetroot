extends "res://src/Interactable/Interactable.gd"

signal begin_dialog(player_obj)

onready var player = $InkPlayer

func _ready():
	var game_node = get_tree().root.get_child(0)
	if game_node.has_method("_on_begin_dialogue") and player:
		var _result = connect("begin_dialog", game_node, "_on_begin_dialogue")

func interact():
	.interact()
	emit_signal("begin_dialog", player)
