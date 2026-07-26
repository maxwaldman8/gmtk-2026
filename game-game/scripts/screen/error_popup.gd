extends Control

func _ready() -> void:
	$Label.text = "ERROR " + str(randi_range(0, 10000)) + ":\nCould Not Load File: \"passwords.txt\"\nPermission Denied"
