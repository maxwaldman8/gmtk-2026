extends Control

@onready var apps: Control = $Apps

func _ready() -> void:
	for app: Application in apps.get_children():
		app.dragged_application_layer = get_parent().get_parent().get_parent().get_node("MovedAppLayer")
		app.window_layer = get_parent().get_parent()
