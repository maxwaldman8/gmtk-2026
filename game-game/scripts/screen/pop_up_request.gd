class_name PopUpRequest
extends Control

@onready var window_layer = get_tree().get_first_node_in_group("window_layer")


func _ready() -> void:
	get_parent().closed.connect(window_layer.generate_popups.bind(5))
	get_parent().closed.connect(window_layer.resume_loading_bar.emit)


func _on_yes_pressed() -> void:
	window_layer.generate_popups(50)
	$Yes.disabled = true
	$No.disabled = true
	get_parent().close()


func _on_no_pressed() -> void:
	window_layer.generate_popups(10)
	$Yes.disabled = true
	$No.disabled = true
	get_parent().close()
