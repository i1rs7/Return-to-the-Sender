extends AudioStreamPlayer

const levels_music = preload("res://Assets/soundEffects/Clement Panchout _ Journey _ 2017.wav")
const jump = preload("res://Assets/soundEffects/pixel-jump-319167.mp3")

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
