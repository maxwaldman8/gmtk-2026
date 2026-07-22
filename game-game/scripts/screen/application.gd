class_name Application
extends Control

@export var window_layer : CanvasLayer
@export var window_name : String
var is_opened : bool = false
var is_default_opened : bool = true
var window_instance : GameWindow
const WINDOW_SCENE = preload("res://scenes/screen/window.tscn")


func _ready() -> void:
	if is_default_opened:
		_open_window()


func set_up(w_name: String = "default", w_is_def_open: bool = true):
	window_name = w_name
	is_default_opened = w_is_def_open


func _open_window():
	window_instance = WINDOW_SCENE.instantiate()
	window_instance.set_up(func(): is_opened = false, window_name)
	window_layer.add_child(window_instance)
	is_opened = true


# on double tap:
	# not is_opened: open window by connected window name
	# is_opened: have window scale animation, go to front

func _handle_clicking_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		if event.double_click:
			if is_opened:
				# animation
				pass
			else:
				_open_window()
		else:
			# become selected
			pass

func _on_test_icon_gui_input(event: InputEvent) -> void:
	_handle_clicking_input(event)


func _on_name_label_gui_input(event: InputEvent) -> void:
	_handle_clicking_input(event)
