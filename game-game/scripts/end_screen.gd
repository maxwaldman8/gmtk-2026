extends Control

func _ready() -> void:
	$ProgressLabel.text = "You Completed " + str(SubmissionWebsite.finished_assignments.size()) + "/10 Assignments!"

func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screen/screen_tutorial.tscn")

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
