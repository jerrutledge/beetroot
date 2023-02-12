@tool
extends Node

var _id_counter = 0

# called by children to get their ids in editor
func register_coin(calling_coin):
	calling_coin.coin_id = _id_counter
	print_debug("Assign coin ID: "+str(_id_counter))
	_id_counter += 1
