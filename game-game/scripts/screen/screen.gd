class_name Screen
extends Control

@export var player: CharacterBody3D
@export var gui: CanvasLayer
@export var password_note: CanvasLayer
@export var alarm_note: CanvasLayer
@export var tv_note: CanvasLayer
@export var cat_bowl: CanvasLayer
@export var cat1: CanvasLayer
@export var cat2: CanvasLayer

const cat_names: Array[String] = ["Maxine", "Kaitlyn", "Bobette", "Kikki", "Jiji", "Momo", "Alice", "Ginger"]
const cat_surnames: Array[String] = ["Catson", "Cattenbourg", "Catte", "Cattalia", "Catalan"]
@export var spanish_password_textures: Array[Texture2D]
const spanish_passwords: Array[String] = ["hola1234", "hola5432", "hola6543", "hola4567", "hola5678", "hola9876"]
@export var english_password_1s: Array[Texture2D]
const english_password_endings: Array[String] = ["654321", "765432", "876543", "987654"]

@export var time_label: Label

@export var custom_mouse: Resource

static var time: float = 49 * 60

@export var tutorial: bool = false

var watched_question_video: bool = false
var watched_ad_video: bool = false

# Randomly generated stuff
var messaging_password: String
var cat_name: String
var cat_surname: String
var maze_num: int
var spanish_password_texture: Texture2D
var spanish_password: String
var english_password_1_texture: Texture2D
var english_password: String

func _enter_tree() -> void:
	if !tutorial:
		SubmissionWebsite.assignments_to_do = ["task_invaders"]
	else:
		SubmissionWebsite.assignments_to_do = ["tutorial"]
	SubmissionWebsite.finished_assignments = []
	SubmissionWebsite.missing_assignments = []
	
func _ready() -> void:
	Input.set_custom_mouse_cursor(custom_mouse, Input.CURSOR_ARROW)
	if tutorial:
		time = 48 * 60
	else:
		if !MusicSetting.music:
			get_tree().root.get_node("Room/DigitalMusic").volume_db = -85
		time = 49 * 60
		messaging_password = "egg" + str(randi_range(100, 999)).replace("5", "6")
		password_note.get_node("Label").text = "logotmessage password\n\n" + messaging_password
		maze_num = randi_range(1, 5)
		cat_name = cat_names[randi_range(0, cat_names.size() - 1)]
		cat_surname = cat_surnames[randi_range(0, cat_surnames.size() - 1)]
		cat_bowl.get_node("Label").text = cat_name
		cat1.get_node("Label").text = cat_name
		cat2.get_node("Label").text = cat_name
		cat2.get_node("Label2").text = cat_surname
		var spanish_password_num = randi_range(0, spanish_password_textures.size() - 1)
		spanish_password_texture = spanish_password_textures[spanish_password_num]
		spanish_password = spanish_passwords[spanish_password_num]
		var english_password_num = randi_range(0, english_password_1s.size() - 1)
		english_password_1_texture = english_password_1s[english_password_num]
		english_password = "QWERTYasdfgh" + english_password_endings[english_password_num]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape_screen"):
		if !tutorial:
			if MusicSetting.music:
				get_tree().root.get_node("Room/RealMusic").volume_db = -15
				get_tree().root.get_node("Room/DigitalMusic").volume_db = -80
			player.process_mode = Node.PROCESS_MODE_ALWAYS
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_parent().get_parent().visible = false
			gui.visible = true

func _process(delta: float) -> void:
	if time >= 59.0 * 60.0:
		# Fail
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	if !tutorial:
		#time += delta
		if int(floor(time)) % 60 < 10:
			time_label.text = "11:" + str(int(time / 60.0)) + ":0" + str(int(time) % 60) + " PM"
		else:
			time_label.text = "11:" + str(int(time / 60.0)) + ":" + str(int(time) % 60) + " PM"
	else:
		time_label.text = "11:48 PM"
	$WallpaperLayer/WindowsOpenLabel.text = "Windows Open: " + str($WindowLayer.get_child_count())

func set_wallpaper(texture: Texture2D):
	$WallpaperLayer/Wallpaper.texture = texture

func handle_missing(a_name: String):
	match a_name:
		"tutorial":
			print("this is impossible")
		"conversion":
			SubmissionWebsite.assignments_to_do = ["message_3d"]
		"message_3d":
			SubmissionWebsite.assignments_to_do = ["question_video"]
		"question_video":
			SubmissionWebsite.assignments_to_do = ["pop_up"]
		"pop_up":
			SubmissionWebsite.assignments_to_do = ["movie_ads"]
		"movie_ads":
			SubmissionWebsite.assignments_to_do = ["image_puzzle_and_cat"]
		"image_puzzle_and_cat":
			SubmissionWebsite.assignments_to_do = ["task_invaders", "wallpaper", "alarm_clock"]
			$ApplicationLayer/TaskManager.window_scene_name = "task_manager_game_window"
			Cat.flying = true

# Finishing tasks functions
func download_pdf():
	$ApplicationLayer/SpeechPDF.visible = true

func download_english_essay():
	$ApplicationLayer/EnglishEssay.visible = true

func download_spanish_essay():
	$ApplicationLayer/SpanishEssay.visible = true

func download_question_video():
	$ApplicationLayer/QuestionVideo.visible = true

func download_ad_video():
	$ApplicationLayer/AdVideo.visible = true

func submit_math_homework():
	$ApplicationLayer/TutorialComplete._open_window()

func submit_public_speaking():
	SubmissionWebsite.assignments_to_do = ["message_3d"]

func submit_lab_data():
	SubmissionWebsite.assignments_to_do = ["question_video"]

func submit_question_video():
	SubmissionWebsite.assignments_to_do = ["pop_up"]

func submit_popup():
	SubmissionWebsite.assignments_to_do = ["movie_ads"]

func submit_ad_video():
	SubmissionWebsite.assignments_to_do = ["image_puzzle_and_cat"]

func submit_english_essay():
	SubmissionWebsite.assignments_to_do = ["task_invaders", "wallpaper", "alarm_clock"]
	$ApplicationLayer/TaskManager.window_scene_name = "task_manager_game_window"
	Cat.flying = true

func submit_other_assignment():
	if SubmissionWebsite.finished_assignments.size() >= 9:
		# TODO: Play end cutscene
		get_tree().change_scene_to_file("res://scenes/end_screen.tscn")

func insert_drive():
	get_node("ApplicationLayer/Mazes/Maze" + str(maze_num)).visible = true

func finish_maze():
	get_node("ApplicationLayer/Mazes/Maze" + str(maze_num)).visible = false
	$ApplicationLayer/DFSJava.visible = true

func finish_question_video():
	watched_question_video = true

func finish_ad_video():
	watched_ad_video = true

# tween window with mouse
# window pos offset for minimal overlap
