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
	if data.is_empty():
		return
	name_label.text = data[INFO.NAME]
	due_time_label.text = "Due today at " + data[INFO.DUE_DATE] + " in xx:xx"
	desc_label.text = data[INFO.DESC]
	submitted_file_name = ""


func _on_button_pressed() -> void:
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


func _on_submit_button_pressed() -> void:
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
				get_parent().update_a_list()
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().finish_tutorial()
		"conversion":
			var regex = RegEx.new()
			regex.compile(".*\\.pdf")
			if !regex.search(sub_file.text):
				print("not pdf")
				sub_status_label.text = "Incorrect Filetype"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			elif sub_file.text != "speech.pdf":
				print("wrong pdf")
				sub_status_label.text = "Incorrect File"
				sub_status_label.add_theme_color_override("font_color", Color.RED)
			else:
				print("right pdf")
				sub_status_label.text = "Submitted"
				sub_status_label.add_theme_color_override("font_color", Color.GREEN)
				get_parent().finished_assignments.append(a_name)
				get_parent().assignments_to_do.remove_at(get_parent().assignments_to_do.find(a_name))
				get_parent().update_a_list()
				get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().finish_public_speaking()
				get_parent().update_a_list()
