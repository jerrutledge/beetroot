extends ColorRect

export var dialogPath = ""

export(float) var textSpeed = 0.05

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
	#_idc = player.disconnect("InkEnded", self, "_on_story_ink_ended")
	player = null

func _on_story_continued(text, _tags):
	print_debug(text)
	nextPhrase("Nobody", text)
	
func _on_story_choices(choices):
	print_debug(choices)
	pass

func begin_dialog(ink_player):
	visible = true
	print_debug("Dialog started...")
	player = ink_player
	# connect all signals
	var _idc = ink_player.connect("InkChoices", self, "_on_story_choices")
	_idc = ink_player.connect("InkContinued", self, "_on_story_continued")
	#_idc = ink_player.connect("InkEnded", self, "_on_story_ink_ended")
	finished = false
	ink_player.Continue()
