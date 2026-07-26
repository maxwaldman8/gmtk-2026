extends Control

func _ready() -> void:
	if int(floor(Screen.time)) % 60 < 10:
		$ProgressLabel.text = "Your time: " + str(int(Screen.time / 60.0 - 49.0)) + ":0" + str(int(Screen.time) % 60)
	else:
		$ProgressLabel.text = "Your time: " + str(int(Screen.time / 60.0 - 49.0)) + ":" + str(int(Screen.time) % 60)
	if !MusicSetting.music:
		$AudioStreamPlayer2D.volume_db = -85

func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screen/screen_tutorial.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
