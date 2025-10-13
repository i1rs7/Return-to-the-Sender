extends Node

@onready var max_jumps = 2
@onready var max_dash = 1
@onready var lives_left = 3
@onready var cures_obtained = 0

func _ready() -> void:
	Sounds.play_bg_music()
