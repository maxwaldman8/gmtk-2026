class_name Application
extends Control

# shadow is on if clicked it once or is opened
@export var selected_shadow : ColorRect
@export var dragged_ghost : DraggedGhost
@export var icon : Control
@export var icon_image: Texture2D
@export var name_label : Label
@export var panel_container : PanelContainer
@export var input_taker : ColorRect
# for drag purposes
var original_click_pos : Vector2
var is_hovered : bool = false

@export var dragged_application_layer : CanvasLayer
@export var window_layer : WindowLayer
@export var window_name : String
@export var window_scene_name: String
@export var is_default_opened : bool = true
var is_opened : bool = false:
	set(new_is_opened):
		is_opened = new_is_opened
		if not is_opened:
			selected_shadow.visible = false
var window_instance : GameWindow
const WINDOW_SCENE = preload("res://scenes/screen/window.tscn")

var is_dragged : bool = false
var offset : Vector2


func _ready() -> void:
	icon.texture = icon_image
	selected_shadow.visible = is_default_opened
	if is_default_opened:
		_open_window()
	name_label.text = window_name
	dragged_ghost.file_name = window_name

func set_up(w_name: String = "default", w_is_def_open: bool = true):
	window_name = w_name
	is_default_opened = w_is_def_open


func _open_window():
	window_instance = WINDOW_SCENE.instantiate()
	window_instance.set_up(window_scene_name, window_name, false, self)
	window_layer.add_to_window_list(window_instance)
	is_opened = true


func _input(event: InputEvent) -> void:
	if not is_hovered and event.is_action_pressed("left_click") and not is_opened:
		selected_shadow.visible = false


func _handle_clicking_input(event: InputEvent):
	if event is InputEventMouseButton and event.is_action_pressed("left_click"):
		if event.double_click:
			if is_opened:
				window_layer.move_window_to_front(window_instance)
				var tween = create_tween()
				tween.set_trans(Tween.TRANS_SPRING)
				tween.tween_property(window_instance, "scale", Vector2(1.2,1.2), 0.25)
				tween.tween_property(window_instance, "scale", Vector2(1,1), 0.25)
			else:
				_open_window()
		else:
			selected_shadow.visible = true


func _on_test_icon_gui_input(event: InputEvent) -> void:
	_handle_clicking_input(event)


func _on_name_label_gui_input(event: InputEvent) -> void:
	_handle_clicking_input(event)


func _on_input_taker_gui_input(event: InputEvent) -> void:
	_handle_clicking_input(event)
	# drag
	if event.is_action_pressed("left_click"):
		# just clicked
		is_dragged = true
		original_click_pos = get_global_mouse_position()
	elif event.is_action_released("left_click"):
		if not is_dragged:
			return
		is_dragged = false
		if not dragged_ghost.in_drop_space:
			var tween = create_tween()
			# hard coded vector offset from ghost becoming a new scene
			tween.tween_property(dragged_ghost, "global_position", global_position + Vector2(30, 40), 0.25)
			await tween.finished
		else:
			dragged_ghost.was_dropped = true
			dragged_ghost.dropped_ghost.emit()
		#dragged_application_layer.remove_child(dragged_ghost)
		dragged_ghost.reparent(self)
		dragged_ghost.collision.disabled = true
		for c in dragged_ghost.get_children():
			if not c is Area2D:
				c.queue_free()


const DRAG_DIST_THRESHOLD = 10
func _process(_delta: float) -> void:
	if not is_dragged:
		return
	var global_mouse_pos = get_global_mouse_position()
	# child count 1 because collider
	if global_mouse_pos.distance_to(original_click_pos) > DRAG_DIST_THRESHOLD and dragged_ghost.get_child_count() == 1:
		dragged_ghost.was_dropped = false
		offset = get_local_mouse_position()
		var new_label_panel = panel_container.duplicate()
		new_label_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
		dragged_ghost.add_child(new_label_panel)
		var new_icon = icon.duplicate()
		new_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
		dragged_ghost.add_child(new_icon)
		#remove_child(dragged_ghost)
		#dragged_application_layer.add_child(dragged_ghost)
		dragged_ghost.reparent(dragged_application_layer)
		dragged_ghost.collision.disabled = false
	# hard coded vector offset since made ghost a new scene
	var unclamped_pos : Vector2 = global_mouse_pos - offset + Vector2(30, 40)
	dragged_ghost.global_position = unclamped_pos.clamp(Vector2.ZERO, get_viewport_rect().size - size)


func _on_input_taker_mouse_entered() -> void:
	is_hovered = true


func _on_input_taker_mouse_exited() -> void:
	is_hovered = false
