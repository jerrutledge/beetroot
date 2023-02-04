extends ColorRect

export var dialogPath = ""

export(float) var textSpeed = 0.05

onready var options = $Options

var player = null
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	visible = false
	
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
	var _idc = player.disconnect("InkChoices", self, "_on_story_choices")
	_idc = player.disconnect("InkContinued", self, "_on_story_continued")
	_idc = player.disconnect("InkEnded", self, "_on_story_ink_ended")
	player.LoadStory()
	player = null

func _on_story_continued(text, tags):
	print(tags)
	nextPhrase("Nobody", text)
	
func _on_story_choices(choices):
	var i = 0
	for choice in choices:
		var new_button = Button.new()
		new_button.connect("pressed", self, "_on_choice_click", [i])
		new_button.text = choice
		options.add_child(new_button)
		i += 1

func _on_choice_click(choicenum):
	print_debug("choicenum")
	for n in options.get_children():
		options.remove_child(n)
		n.queue_free()
	var next_text = player.ChooseChoiceIndexAndContinue(choicenum);
	nextPhrase("", next_text)

func begin_dialog(ink_player):
	if (player != null):
		return
	visible = true
	print_debug("Dialog started...")
	player = ink_player
	# connect all signals
	var _idc = ink_player.connect("InkChoices", self, "_on_story_choices")
	_idc = ink_player.connect("InkContinued", self, "_on_story_continued")
	_idc = ink_player.connect("InkEnded", self, "_on_story_ink_ended")
	finished = false
	ink_player.Continue()
