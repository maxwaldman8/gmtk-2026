class_name SubmissionWebsite
extends BrowserWebsite

@export var assignments_list : VBoxContainer
@export var to_do_list : Control
@export var assignment_page : AssignmentPage

static var assignments_to_do : PackedStringArray = []
static var finished_assignments : PackedStringArray = []

const ASSIGNMENT_TAB_SCENE = preload("res://scenes/screen/windows/browser websites/assignment_tab.tscn")


func _ready() -> void:
	to_do_list.visible = true
	assignment_page.visible = false
	assignment_page.swap.connect(swap_to)
	if assignments_to_do.is_empty() and finished_assignments.is_empty():
		assignments_to_do = AssignmentsData.d.keys()
	# removal is temp to not see tutorial
	assignments_to_do.remove_at(0)
	if "tutorial" in assignments_to_do:
		var tutorial = ASSIGNMENT_TAB_SCENE.instantiate()
		tutorial.set_up("tutorial")
		tutorial.swap_to.connect(swap_to)
		assignments_list.add_child(tutorial)
		return
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
