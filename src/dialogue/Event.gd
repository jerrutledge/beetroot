extends Area2D

onready var player = $InkPlayer
export(String) var start = ""

signal begin_dialog(player_obj, calling_obj, vars)

func _ready():
	var game_node = get_tree().root.get_child(0)
	if game_node.has_method("_on_begin_dialogue") and player:
		var _result = connect("begin_dialog", game_node, "_on_begin_dialogue")

func _on_Node2D_area_entered(area):
	print_debug(area)
	if area.is_in_group("current_player"):
		print_debug("area")
		emit_signal("begin_dialog", player, self, start)
