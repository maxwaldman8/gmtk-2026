class_name AssignmentPage
extends Control

signal swap

@export var name_label : Label
@export var due_time_label : Label
@export var desc_label : Label
@export var back_button : Button
@export var sub_status_label : Label
@export var sub_file : Label
@export var delete_file_button : Button
@export var submit_button : Button
@export var loading_bar : LoadingBar

@onready var screen: Screen = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent()

var submitted_file_name : String:
	set(new_file):
		submitted_file_name = new_file
		if new_file == "":
			sub_file.text = "drag file here"
			delete_file_button.visible = false
			return
		sub_file.text = submitted_file_name
		delete_file_button.visible = true
var hovered_file_name : String = ""

var a_name : String

var data : Array
enum INFO {
	NAME, CLASS, COLOR, DUE_DATE, DESC
}


func set_up(new_a_name: String = "tutorial"):
	a_name = new_a_name
	data = AssignmentsData.d[a_name]
	if is_node_ready():
		_ready()


func _ready() -> void:
	loading_bar.reset()
	delete_file_button.visible = true
	submit_button.visible = true
	if data.is_empty():
		return
	name_label.text = data[INFO.NAME]
	due_time_label.text = "Due today at " + data[INFO.DUE_DATE] + " in xx:xx"
	desc_label.text = data[INFO.DESC]
	submitted_file_name = ""

func _process(_delta: float) -> void:
	if data.size() == 0: return
	var current_time: float = screen.time
	var due_time: float = data[INFO.DUE_DATE].substr(3, 2).to_int() * 60.0
	var time_left = int(ceil(due_time - current_time))
	var minutes = "0"
	if time_left / 60 < 10:
		minutes = "0" + str(time_left / 60)
	else:
		minutes = str(time_left / 60)
	var seconds = "0"
	if time_left % 60 < 10:
		seconds = "0" + str(time_left % 60)
	else:
		seconds = str(time_left % 60)
	due_time_label.text = "Due today at " + data[INFO.DUE_DATE] + " in " + minutes + ":" + seconds


func _on_button_pressed() -> void:
	loading_bar.reset()
	swap.emit()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not area.get_parent() is DraggedGhost:
		return
	var ghost_app : DraggedGhost = area.get_parent()
	if ghost_app.was_dropped:
		return
	hovered_file_name = ghost_app.file_name
	ghost_app.in_drop_space = true
	ghost_app.dropped_ghost.connect(func(): 
		submitted_file_name = hovered_file_name
		loading_bar.reset()
	)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if not area.get_parent() is DraggedGhost:
		return
	var ghost_app : DraggedGhost = area.get_parent()
	if ghost_app.was_dropped:
		return
	hovered_file_name = ""
	ghost_app.in_drop_space = false


func _on_delete_file_button_pressed() -> void:
	submitted_file_name = ""
	loading_bar.reset()


const WINDOW_SCENE = preload("res://scenes/screen/window.tscn")
func open_loading_pop_up_window():
	var window_layer : WindowLayer = get_tree().get_first_node_in_group("window_layer")
	var window_instance : GameWindow = WINDOW_SCENE.instantiate()
	window_instance.set_up("pop_up_request", "File Loading Improvement Services", true)
	window_layer.add_to_window_list(window_instance)
	await window_layer.resume_loading_bar
	loading_bar.stop_at = -1


func _on_submit_button_pressed() -> void:
	if submitted_file_name == "":
		return
	if a_name == "pop_up":
		loading_bar.stop_at = 50
		if not loading_bar.stopped.is_connected(open_loading_pop_up_window):
			loading_bar.stopped.connect(open_loading_pop_up_window)
	elif loading_bar.stopped.is_connected(open_loading_pop_up_window):
		loading_bar.stopped.disconnect(open_loading_pop_up_window)
	if not loading_bar.started:
		loading_bar.start()


func _on_loading_bar_finished() -> void:
	if sub_file.text == "drag file here":
		sub_status_label.text = "No File to Submit"
		sub_status_label.add_theme_color_override("font_color", Color.RED)
		return
	match a_name:
		"tutorial":
			if !sub_file.text != "math_homework.pdf":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				screen.finish_tutorial()
				get_parent().update_a_list()
		"conversion":
			var regex = RegEx.new()
			regex.compile(".*\\.pdf")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "speech.pdf":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				screen.submit_public_speaking()
				get_parent().update_a_list()
		#TODO: Message 3d
		"question_video":
			var regex = RegEx.new()
			regex.compile(".*\\.mp4")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "space_invaders.mp4":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif !screen.watched_question_video:
				sub_status_label.text = "Video Has Not Been Completed"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				screen.submit_question_video()
				get_parent().update_a_list()
		#TODO: popup
		"pop_up":
			var regex = RegEx.new()
			regex.compile(".*\\.pdf")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "poster_ad.pdf":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				screen.submit_popup()
				get_parent().update_a_list()
		"movie_ads":
			var regex = RegEx.new()
			regex.compile(".*\\.mp4")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "castlevania.mp4":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif !screen.watched_ad_video:
				sub_status_label.text = "Video Has Not Been Completed"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				screen.submit_ad_video()
				get_parent().update_a_list()
		"image_puzzle_and_cat":
			var regex = RegEx.new()
			regex.compile(".*\\.docx")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "english_essay.docx":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				screen.submit_english_essay()
				get_parent().update_a_list()
		"task_invaders":
			var regex = RegEx.new()
			regex.compile(".*\\.pdf")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "project_report.pdf":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				get_parent().update_a_list()
		"wallpaper":
			var regex = RegEx.new()
			regex.compile(".*\\.docx")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "spanish_essay.docx":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				get_parent().update_a_list()
		"alarm_clock":
			var regex = RegEx.new()
			regex.compile(".*\\.java")
			if !regex.search(sub_file.text):
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "dfs.java":
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				get_parent().update_a_list()
	if sub_status_label.text == "Submitted":
		delete_file_button.visible = false
		delete_file_button.disabled = true
		submit_button.visible = false
		submit_button.disabled = true
