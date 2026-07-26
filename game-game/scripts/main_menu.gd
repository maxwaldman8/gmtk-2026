extends Control

func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screen/screen_tutorial.tscn")

func _on_music_button_pressed() -> void:
	MusicSetting.music = !MusicSetting.music
	if MusicSetting.music:
		$MusicButton.text = "Music: ON"
		$AudioStreamPlayer2D.volume_db = 0
	else:
		$MusicButton.text = "Music: OFF"
		$AudioStreamPlayer2D.volume_db = -85

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_timer_timeout() -> void:
	$Timer/ColonBlocker.visible = not $Timer/ColonBlocker.visible
