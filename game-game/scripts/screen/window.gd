extends Control

# Will be changing types once get textures/whatnot
@onready var title_bar : ColorRect = $TitleBar
@onready var window_body : ColorRect

var dimensions : Vector2i: set = _set_dimensions
var body_name : String

var is_hovered : bool
var is_following_mouse : bool = false

const TITLE_BAR_THICKNESS = 20

# Make window draggable by title bar
# Window bodies will be differing scenes that are loaded in (title bar with X is common functionality)


func set_up(w_dimensions = Vector2i(50, 50), w_body_name = "some default"):
	dimensions = w_dimensions
	body_name = w_body_name


func _set_dimensions(new_dimensions: Vector2i) -> void:
	title_bar.size = Vector2i(new_dimensions.x, TITLE_BAR_THICKNESS)


#region title bar

func _on_x_button_pressed() -> void:
	# closing animation?, sound
	queue_free()


func _on_title_bar_mouse_entered() -> void:
	is_hovered = true


func _on_title_bar_mouse_exited() -> void:
	is_hovered = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		# just clicked
		is_following_mouse = is_hovered
	elif Input.is_action_pressed("left_click"):
		# holding click
		if is_following_mouse:
			global_position = get_global_mouse_position()

#endregion
