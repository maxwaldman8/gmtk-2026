extends Control

func _ready() -> void:
	if !MusicSetting.music:
		$AudioStreamPlayer2D.volume_db = -85

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
