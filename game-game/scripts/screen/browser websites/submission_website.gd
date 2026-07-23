class_name SubmissionWebsite
extends BrowserWebsite

@export var assignments_list : VBoxContainer

static var assignments_to_do : PackedStringArray = []
static var finished_assignments : PackedStringArray = []

const ASSIGNMENT_TAB_SCENE = preload("res://scenes/screen/windows/browser websites/assignment_tab.tscn")


func _ready() -> void:
	if assignments_to_do.is_empty() and finished_assignments.is_empty():
		assignments_to_do = AssignmentsData.d.keys()
	# removal is temp to not see tutorial
	assignments_to_do.remove_at(0)
	if "tutorial" in assignments_to_do:
		var tutorial = ASSIGNMENT_TAB_SCENE.instantiate()
		tutorial.set_up("tutorial")
		assignments_list.add_child(tutorial)
		return
	for a in assignments_to_do:
		var a_tab = ASSIGNMENT_TAB_SCENE.instantiate()
		a_tab.set_up(a)
		assignments_list.add_child(a_tab)
