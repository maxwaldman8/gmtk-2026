class_name SubmissionWebsite
extends BrowserWebsite

@export var assignments_list : VBoxContainer
@export var to_do_list : Control
@export var assignment_page : AssignmentPage

static var assignments_to_do : PackedStringArray = []
static var finished_assignments : PackedStringArray = []
static var missing_assignments : PackedStringArray = []

const ASSIGNMENT_TAB_SCENE = preload("res://scenes/screen/windows/browser websites/assignment_tab.tscn")
const url = "submissionwebsite.com"
const tab_name = "Submit"


func _ready() -> void:
	to_do_list.visible = true
	assignment_page.visible = false
	assignment_page.swap.connect(swap_to)
	if get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().tutorial:
		var tutorial = ASSIGNMENT_TAB_SCENE.instantiate()
		tutorial.set_up("tutorial")
		tutorial.swap_to.connect(swap_to)
		assignments_list.add_child(tutorial)
	else:
		for a in assignments_to_do:
			var a_tab = ASSIGNMENT_TAB_SCENE.instantiate()
			a_tab.set_up(a)
			a_tab.swap_to.connect(swap_to)
			assignments_list.add_child(a_tab)


func swap_to(...args):
	if not args.is_empty():
		assignment_page.set_up(args[0])
	to_do_list.visible = not to_do_list.visible
	assignment_page.visible = not assignment_page.visible


func update_a_list():
	for a_tab:AssignmentTab in assignments_list.get_children():
		if a_tab.a_name not in assignments_to_do:
			a_tab.queue_free()
	for a_name in assignments_to_do:
		var already_there : bool = false
		for a_tab:AssignmentTab in assignments_list.get_children():
			if a_tab.a_name == a_name:
				already_there = true
		if not already_there:
			var a_tab = ASSIGNMENT_TAB_SCENE.instantiate()
			a_tab.set_up(a_name)
			a_tab.swap_to.connect(swap_to)
			assignments_list.add_child(a_tab)


func get_url():
	return url
