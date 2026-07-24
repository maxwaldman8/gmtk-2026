class_name AssignmentPage
extends Control

signal swap

@export var name_label : Label
@export var due_time_label : Label
@export var desc_label : Label
@export var button : Button

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


func _on_button_pressed() -> void:
	swap.emit()
