class_name Application
extends Control

var window_name : String
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


func _input(event: InputEvent) -> void:
	if event.is_pressed() and event.is_action_pressed("left_click") and event.double_click:
		pass


func _open_window():
	window_instance = WINDOW_SCENE.instantiate()
	window_instance.set_up(window_name)


# on double tap:
	# not is_opened: open window by connected window name
	# is_opened: have window scale animation, go to front
func _on_test_icon_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		if event.double_click:
			_open_window()
		else:
			# become selected
			print("single click")
