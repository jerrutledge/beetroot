extends ColorRect

signal dialog_start()
signal dialog_end()

export var dialogPath = ""

export(float) var textSpeed = 0.05

onready var options = $Options

var player = null
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	visible = false
	$Name.text = ""
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished and player != null:
			finished = false
			player.Continue()
		else:
			$Text.visible_characters = len($Text.text) 
	
func nextPhrase(name, text):
	$Name.text = name
	$Text.text = text
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
		
	finished = true
	return

func _on_story_ink_ended():
	visible = false
	print_debug("Dialog finished.")
	# disconnect all signals
	var tree = get_tree()
	tree.paused = false
	emit_signal("dialog_end")
	var _idc = player.disconnect("InkChoices", self, "_on_story_choices")
	_idc = player.disconnect("InkContinued", self, "_on_story_continued")
	_idc = player.disconnect("InkEnded", self, "_on_story_ink_ended")
	player = null

func _on_story_continued(text, tags):
	print_debug(player.GetState())
	var text_name = ""
	if tags.size() > 0:
		text_name = tags[0]
	nextPhrase(text_name, text)
	
func _on_story_choices(choices):
	var i = 0
	var first_button = null
	for choice in choices:
		var new_button = Button.new()
		new_button.connect("pressed", self, "_on_choice_click", [i])
		new_button.text = choice
		options.add_child(new_button)
		if i == 0:
			first_button = new_button
		i += 1
	$Timer2.start()
	yield($Timer2, "timeout")
	first_button.grab_focus()

func _on_choice_click(choicenum):
	for n in options.get_children():
		options.remove_child(n)
		n.queue_free()
	var next_text = player.ChooseChoiceIndexAndContinue(choicenum);
	nextPhrase("", next_text)

func begin_dialog(ink_player, _npc, start):
	if (player != null):
		return
	visible = true
	print_debug("Dialog started...")
	player = ink_player
	player.ChoosePathString(start)
	emit_signal("dialog_start")
	# connect all signals
	var tree = get_tree()
	tree.paused = true
	
	var _idc = ink_player.connect("InkChoices", self, "_on_story_choices")
	_idc = ink_player.connect("InkContinued", self, "_on_story_continued")
	_idc = ink_player.connect("InkEnded", self, "_on_story_ink_ended")
	finished = false
	ink_player.Continue()
