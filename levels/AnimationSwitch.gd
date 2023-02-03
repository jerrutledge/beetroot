extends AnimationPlayer
# toggles pause / play

func toggle_animation():
	if is_playing():
		stop(false) # pause
	else:
		play() # play
