extends AudioStreamPlayer

const levels_music = preload("res://Assets/soundEffects/bgmusic.mp3")

func play_music(music: AudioStream, volume = -20.0):
	if stream == music: 
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_sounds(music: AudioStream, volume = 0.0):
	if stream == music: 
		return
		
	stream = music
	volume_db = volume
	play()
	
func play_bg_music():
	play_music(levels_music)
