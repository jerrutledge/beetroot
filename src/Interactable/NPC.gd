extends "res://src/Interactable/Interactable.gd"

signal begin_dialog(player_obj, calling_obj, vars)

@onready var player = $InkPlayer
var vars
@export var start: String = ""

func _ready():
	vars = []
	var game_node = get_tree().root.get_child(0)
	if game_node.has_method("_on_begin_dialogue") and player:
		var _result = connect("begin_dialog",Callable(game_node,"_on_begin_dialogue"))

func interact():
	super.interact()
	emit_signal("begin_dialog", player, self, start)

func update_vars(new_vars):
	vars = new_vars
