extends Control

@export var body : ColorRect
@export var disabled : bool = true
@export var person_name : String


func _ready() -> void:
	$Body/NameLabel.text = person_name
	if disabled:
		body.color = Color(0.211, 0.211, 0.211, 1.0)
	else:
		body.color = Color(1.0, 1.0, 1.0, 1.0)
