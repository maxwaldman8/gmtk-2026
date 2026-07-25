class_name AssignmentTab
extends Control

signal swap_to(assignment_name: String)

@export var color_box : ColorRect
@export var class_label : Label
@export var assignment_label : Label
@export var due_time_label : Label

var a_name : String

var status: String

var data : Array
enum INFO {
	NAME, CLASS, COLOR, DUE_DATE, DESC
}


func set_up(new_a_name: String = "tutorial", new_status: String = "to-do"):
	a_name = new_a_name
	data = AssignmentsData.d[a_name]
	status = new_status


func _ready() -> void:
	assignment_label.text = data[INFO.NAME]
	class_label.text = data[INFO.CLASS]
	class_label.add_theme_color_override("font_color", data[INFO.COLOR])
	if status == "to-do":
		due_time_label.text = "Due today at " + data[INFO.DUE_DATE]
	elif status == "completed":
		due_time_label.text = "Completed"
		due_time_label.add_theme_color_override("font_color", Color.GREEN)
	elif status == "missing":
		due_time_label.text = "Missing"
		due_time_label.add_theme_color_override("font_color", Color.RED)
	color_box.color = data[INFO.COLOR]


func _on_button_pressed() -> void:
	swap_to.emit(a_name)
