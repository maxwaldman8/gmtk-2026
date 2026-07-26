extends Control

@export var a_name_label : Label

func _ready() -> void:
	var code_name = SubmissionWebsite.missing_assignments[-1]
	a_name_label.text = AssignmentsData.d[code_name][0]
