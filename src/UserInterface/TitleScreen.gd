extends Control

func _ready():
	$Control/Play.grab_focus()

func start_game():
	var _idc = get_tree().change_scene("res://src/Main/Game.tscn")

