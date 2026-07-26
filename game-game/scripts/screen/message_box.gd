extends Control

var message = "":
	set(new_message):
		message = new_message
		$ColorRect/Label.text = message
@export var is_you : bool

func _ready() -> void:
	#$ColorRect/Label.text = message
	if is_you:
		$ColorRect.color = Color(0.353, 0.627, 0.98, 1.0)
		$ColorRect.position = Vector2(89, 0)
	else:
		$ColorRect.color = Color(0.902, 0.902, 0.902, 1.0)
		#$ColorRect.set_anchors_preset(Control.LayoutPreset.PRESET_TOP_LEFT, true)
