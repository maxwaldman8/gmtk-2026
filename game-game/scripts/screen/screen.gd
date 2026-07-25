class_name Screen
extends Control

@export var player: CharacterBody3D
@export var gui: CanvasLayer
@export var password_note: CanvasLayer
@export var tv_note: CanvasLayer
@export var cat_bowl: CanvasLayer

const cat_names: Array[String] = ["Maxine", "Kaitlyn", "Bobette", "Kikki", "Jiji", "Momo", "Alice", "Ginger"]
var cat_name

@export var time_label: Label

@export var custom_mouse: Resource

var time: float = 49 * 60

var tutorial: bool = false

# Randomly generated stuff
var messaging_password: String
var maze_num: int

func _enter_tree() -> void:
	if !tutorial:
		SubmissionWebsite.assignments_to_do = ["conversion"]
	else:
		SubmissionWebsite.assignments_to_do = ["tutorial"]
	SubmissionWebsite.finished_assignments = []
	SubmissionWebsite.missing_assignments = []
	
func _ready() -> void:
	Input.set_custom_mouse_cursor(custom_mouse, Input.CURSOR_ARROW)
	messaging_password = "egg" + str(randi_range(100, 999)).replace("5", "6")
	password_note.get_node("Label").text = "logotmessage password\n\n" + messaging_password
	maze_num = randi_range(1, 5)
	cat_name = cat_names[randi_range(0, cat_names.size() - 1)]
	cat_bowl.get_node("Label").text = cat_name

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

func set_wallpaper(texture: Texture2D):
	$WallpaperLayer/Wallpaper.texture = texture

# Finishing tasks functions
func download_pdf():
	$ApplicationLayer/SpeechPDF.visible = true

func finish_public_speaking():
	SubmissionWebsite.assignments_to_do = ["message_3d"]
	

func insert_drive():
	get_node("ApplicationLayer/Mazes/Maze" + str(maze_num)).visible = true

func finish_maze():
	get_node("ApplicationLayer/Mazes/Maze" + str(maze_num)).visible = false

func finish_question_video():
	pass

func finish_ad_video():
	pass

# tween window with mouse
# window pos offset for minimal overlap
