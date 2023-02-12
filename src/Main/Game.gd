extends Node
# This class contains controls that should always be accessible, like pausing
# the game or toggling the window full-screen.
# it also handles loading and storing data between levels

# The "_" prefix is a convention to indicate that variables are private,
# that is to say, another node or script should not access them.
@onready var _pause_menu = $InterfaceLayer/PauseMenu
@onready var _dialog_box = $DialogueLayer/DialogBox

var player_scene = preload("res://src/Actors/Player.tscn")
var _level_node = null
# a dictionary where the name of each level corresponds to an array 
# of the coin ids that have already been collected e.g. "Grass": [0, 3]
var _coin_dict = {}

@export var starting_level_name: String = "Level"
@export var starting_level_player_position: Vector2 = Vector2(136, 560)
#export var starting_level_player_position: Vector2 = Vector2(136, 0)

func _init():ject in memory




func _ready(): #node children loaded & node loaded
	switch_level(starting_level_name, starting_level_player_position)


func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		# We need to clean up a little bit first to avoid SubViewport errors.
		if name == "Splitscreen":
			$Black/SplitContainer/ViewportContainer1.free()
			$Black.queue_free()


func _unhandled_input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (not ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))) else Window.MODE_WINDOWED
		get_viewport().set_input_as_handled()
	# The GlobalControls node, in the Stage scene, is set to process even
	# when the game is paused, so this code keeps running.
	# To see that, select GlobalControls, and scroll down to the Pause category
	# in the inspector.
	elif event.is_action_pressed("toggle_pause"):
		if _dialog_box.visible: return
		var tree = get_tree()
		tree.paused = not tree.paused
		if tree.paused:
			_pause_menu.open()
		else:
			_pause_menu.close()
		get_viewport().set_input_as_handled()


func _on_switch_to_level(level_name, new_level_player_spawn):
	# this may be executed during a physics call, so we will defer it 
	call_deferred("switch_level", level_name, new_level_player_spawn)

func switch_level(level_name, new_level_player_spawn):
	print_debug(level_name, new_level_player_spawn)
	if not (_level_node == null):
		_level_node.name = _level_node.name + "old"
		_level_node.queue_free()
	_level_node = load("res://levels/" + level_name + ".tscn").instantiate()
	_level_node.name = level_name
	if not level_name in _coin_dict:
		_coin_dict[level_name] = []
	add_child(_level_node)


	var player = player_scene.instantiate()
	player.set_position(new_level_player_spawn)
	player.connect("collect_coin",Callable(self,"_on_collect_coin"))
	_dialog_box.connect("dialog_start",Callable(player,"_on_dialog_start"))
	_dialog_box.connect("dialog_end",Callable(player,"_on_dialog_end"))
	_level_node.add_child(player)


func _on_collect_coin(coin_id):
	if _level_node != null:
		_coin_dict[_level_node.name].append(coin_id)
		print_debug("coin "+str(coin_id)+" collected")
		print_debug(_coin_dict[_level_node.name])

func is_coin_id_valid(coin_id):
	if _level_node != null:
		if _level_node.name in _coin_dict:
			return not coin_id in _coin_dict[_level_node.name]
		else:
			print_debug(_level_node.name + " not in coin dict")
			return true

func _on_begin_dialogue(ink_player, npc, start):
	_dialog_box.begin_dialog(ink_player, npc, start)
