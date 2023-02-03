extends Area2D

signal change_level(level_name, new_level_player_spawn)

export(String) var new_level_name = "Grass"
export(Vector2)var new_level_player_spawn = Vector2.ZERO

func _ready():
	# notify the root when it's time to get the 
	var game_node = get_tree().root.get_child(0)
	print_debug(game_node.has_method("_on_switch_to_level"))
	if game_node.has_method("_on_switch_to_level"):
		var _idc = connect("change_level", game_node, "_on_switch_to_level")

func _on_Portal_body_entered(_body):
	emit_signal("change_level", new_level_name, new_level_player_spawn)
	queue_free()
