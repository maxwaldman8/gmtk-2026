class_name AssignmentPage
extends Control

signal swap

@export var name_label : Label
@export var due_time_label : Label
@export var desc_label : Label
@export var button : Button
@export var sub_status_label : Label
@export var sub_file : Label

var submitted_file_name : String:
	set(new_file):
		submitted_file_name = new_file
		if new_file == "":
			sub_file.text = "drag file here"
			return
		sub_file.text = submitted_file_name

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
	var ghost_app = area.get_parent()
	var app_name_label : Label
	for node in ghost_app.get_children():
		if node is Label:
			app_name_label = node
			break
	print(app_name_label.text)


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
