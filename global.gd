extends Node

@onready var max_jumps = 2
@onready var max_dash = 1

func _ready() -> void:
	Sounds.play_bg_music()
