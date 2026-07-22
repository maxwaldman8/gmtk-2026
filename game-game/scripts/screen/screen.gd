class_name Screen
extends Control

@export var player: CharacterBody3D
@export var gui: CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape_screen"):
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_parent().get_parent().visible = false
		gui.visible = true

# window layering: clicked one is first
# tween window with mouse
