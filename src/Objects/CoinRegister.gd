@tool
extends Node

# This class has to be parented by a CoinManager
@export var coin_id: int = 0
@onready var coin_object = $CoinObject

# we need to add a unique coin ID for every coin placed in the level
func _ready():
	if Engine.editor_hint:
		# in editor only:
		get_tree().call_group("coinmanager", "register_coin", self)
		return
	remove_child(coin_object)

	var game_node = get_tree().root.get_child(0)
	if game_node.is_coin_id_valid(coin_id):
		coin_object.coin_id = coin_id
		add_child(coin_object)
	else:
		queue_free()
