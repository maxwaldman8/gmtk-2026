class_name GameWindow
extends Control

signal closed

# Will be changing types once get textures/whatnot
@onready var title_bar : ColorRect = $TitleBar
@onready var title_label : Label = $TitleBar/TitleLabel
@onready var window_body : ColorRect
@onready var window_layer : WindowLayer = get_parent()
var body_scene : PackedScene
var body_name : String
var dimensions : Vector2: set = _set_dimensions

var body_instance

var is_hovered : bool
var is_following_mouse : bool = false
var offset : Vector2
const TITLE_BAR_THICKNESS = 20


func _ready() -> void:
	dimensions = body_instance.size + Vector2(0, TITLE_BAR_THICKNESS)
	pivot_offset = dimensions / 2
	title_label.text = body_name


func set_up(app_close_fn, w_body_name = "default_window"):
	body_name = w_body_name
	body_scene = load("res://scenes/screen/windows/" + body_name + ".tscn")
	body_instance = body_scene.instantiate()
	body_instance.position.y += TITLE_BAR_THICKNESS
	add_child(body_instance)
	# pos will be set in window layer later
	global_position = Vector2i(500, 300)
	closed.connect(app_close_fn)


func _set_dimensions(new_dimensions: Vector2i) -> void:
	dimensions = new_dimensions
	title_bar.size = Vector2i(new_dimensions.x, TITLE_BAR_THICKNESS)


#region title bar

func _on_x_button_pressed() -> void:
	# closing animation?, sound
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "scale", Vector2(0,0), 0.5)
	await tween.finished
	closed.emit()
	window_layer.remove_window(self)
	queue_free()


func _on_title_bar_mouse_entered() -> void:
	is_hovered = true


func _on_title_bar_mouse_exited() -> void:
	is_hovered = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and is_hovered:
		# just clicked
		is_following_mouse = true
		offset = get_local_mouse_position()
		window_layer.move_window_to_front(self)
	elif Input.is_action_pressed("left_click"):
		# holding click
		if is_following_mouse:
			var unclamped_pos : Vector2 = get_global_mouse_position() - offset
			global_position = unclamped_pos.clamp(Vector2.ZERO, get_viewport_rect().size - dimensions)
	elif Input.is_action_just_released("left_click"):
		is_following_mouse = false

#endregion
