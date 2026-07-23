class_name Screen
extends Control

@export var player: CharacterBody3D
@export var gui: CanvasLayer

@export var time_label: Label

var time: float = 49 * 60

var tutorial: bool = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape_screen"):
		get_tree().root.get_node("Room").get_node("RealMusic").volume_db = 0
		get_tree().root.get_node("Room").get_node("DigitalMusic").volume_db = -80
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_parent().get_parent().visible = false
		gui.visible = true

func _process(delta: float) -> void:
	if !tutorial:
		time += delta
		if int(floor(time)) % 60 < 10:
			time_label.text = "11:" + str(int(time / 60.0)) + ":0" + str(int(time) % 60) + " PM"
		else:
			time_label.text = "11:" + str(int(time / 60.0)) + ":" + str(int(time) % 60) + " PM"
	else:
		time_label.text = "11:48 PM"

# window layering: clicked one is first
# tween window with mouse
# window pos offset for minimal overlap
