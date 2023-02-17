extends "res://src/Interactable/Interactable.gd"

signal begin_dialog(player_obj, calling_obj, vars)

var vars
export(String) var start = ""

func _ready():
	vars = []
	var game_node = get_tree().root.get_child(0)
	if game_node.has_method("_on_begin_dialogue"):
		var _result = connect("begin_dialog", game_node, "_on_begin_dialogue")

func interact():
	.interact()
	emit_signal("begin_dialog", self, start)

func update_vars(new_vars):
	vars = new_vars
