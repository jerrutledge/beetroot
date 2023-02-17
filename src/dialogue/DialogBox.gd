extends ColorRect

signal dialog_start()
signal dialog_end()

export var dialogPath = ""

export(float) var textSpeed = 0.05

onready var options = $Options
onready var player = $InkPlayer
var in_dialogue = false
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	visible = false
	in_dialogue = false
	$Name.text = ""
	
func _process(_delta):
	if (Input.is_action_just_pressed("ui_accept")):
		continue_dialogue()
	
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
	in_dialogue = false
	emit_signal("dialog_end")

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

func begin_dialog(_npc, start):
	if (in_dialogue):
		return
	visible = true
	print_debug("Dialog started...")
	player.ChoosePathString(start)
	emit_signal("dialog_start")
	# connect all signals
	in_dialogue = true
	finished = false
	player.Continue()

func continue_dialogue():
	if finished and player != null:
		finished = false
		player.Continue()
	else:
		$Text.visible_characters = len($Text.text)

func _on_Leaf_button_pressed():
	continue_dialogue()
