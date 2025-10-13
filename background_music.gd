extends AudioStreamPlayer

const levels_music = preload("res://Assets/soundEffects/Clement Panchout _ Journey _ 2017.wav")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music: 
		return
		
	stream = music
	volume_db = volume
	play()
	
func _play_music_level():
	_play_music(levels_music)
