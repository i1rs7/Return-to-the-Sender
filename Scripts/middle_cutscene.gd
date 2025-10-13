extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("middle")

func _on_lose_dash_pressed() -> void:
	Global.max_dash = 0
	get_tree().change_scene_to_file("res://Scenes/Level 2.tscn")


func _on_lose_double_jump_pressed() -> void:
	Global.max_jumps = 1
	get_tree().change_scene_to_file("res://Scenes/Level 2.tscn")


func _on_skip_pressed() -> void:
	$AnimationPlayer.seek($AnimationPlayer.current_animation_length)
	$Skip.hide()
