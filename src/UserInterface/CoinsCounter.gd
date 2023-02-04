extends Panel

var coins_collected = 0

onready var coins_label = $Label


func _ready():
	coins_label.set_text(str(coins_collected))
	# Static types are necessary here to avoid warnings.
	var anim_sprite: AnimatedSprite = $AnimatedSprite
	anim_sprite.play()


func _collect_coin():
	coins_collected += 1
	coins_label.set_text(str(coins_collected))
