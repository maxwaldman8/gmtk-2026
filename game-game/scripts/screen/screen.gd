class_name Screen
extends Control

@export var player: CharacterBody3D
@export var gui: CanvasLayer
@export var password_note: CanvasLayer

@export var time_label: Label

var time: float = 49 * 60

var tutorial: bool = true

# Randomly generated stuff
var messaging_password: String

func _ready() -> void:
	messaging_password = "egg" + str(randi_range(0, 999)).replace("5", "6")
	password_note.get_node("Label").text = "logotmessage password\n\n" + messaging_password

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape_screen"):
		get_tree().root.get_node("Room/RealMusic").volume_db = 0
		get_tree().root.get_node("Room/DigitalMusic").volume_db = -80
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

# Finishing tasks functions
func insert_drive():
	var maze_num = randi_range(1, 5)
	get_node("ApplicationLayer/Mazes/Maze" + str(maze_num)).visible = true

func finish_question_video():
	pass

func finish_ad_video():
	pass

# tween window with mouse
# window pos offset for minimal overlap
