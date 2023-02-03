extends ColorRect

export var dialogPath = ""

export(float) var textSpeed = 0.05

var dialog 
var phraseNum = 0
var finished = false


func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text) 
	
func getDialog() -> Array:
	return [{"Name": "Guy", "Text": "Hello"}, 
	{"Name": "Guy", "Text": "a ya ya ya ya ya ya ya ya"}, 
	{"Name": "Guy", "Text": "Goodbye"}]
	
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		return
		
	finished = false
	$Name.text = dialog[phraseNum]["Name"]
	$Text.text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
		
	finished = true
	phraseNum += 1
	return
