class_name Screen
extends Control

@export var player: CharacterBody3D
@export var gui: CanvasLayer

@export var time_label: Label

var time: float = 48 * 60

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape_screen"):
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_parent().get_parent().visible = false
		gui.visible = true

func _process(delta: float) -> void:
	time += delta
	time_label.text = "11:" + floor(time / 60) + ":" + floor(time) % 60

# window layering: clicked one is first
# tween window with mouse
# window pos offset for minimal overlap
