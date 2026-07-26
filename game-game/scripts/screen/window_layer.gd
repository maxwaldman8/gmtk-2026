class_name WindowLayer
extends CanvasLayer

signal resume_loading_bar
signal restart_loading_bar


func _ready() -> void:
	pass


func add_to_window_list(window_instance:GameWindow, custom_pos=Vector2.ZERO):
	add_child(window_instance)
	window_instance.window_layer = self
	if not window_instance.is_node_ready():
		await window_instance.ready
	if custom_pos != Vector2.ZERO:
		window_instance.position = custom_pos
		return
	var spawn_maximum : Vector2 = get_viewport().get_visible_rect().size - window_instance.dimensions
	var spawn_pos = Vector2(randf_range(0, spawn_maximum.x), randf_range(0, spawn_maximum.y))
	window_instance.position = spawn_pos


func move_window_to_front(window: GameWindow):
	move_child(window, -1)


const DEFAULT_POPUP_NUM : int = 50
const WINDOW_SCENE = preload("res://scenes/screen/window.tscn")
func generate_popups(...args):
	var count = args[0] if len(args) == 1 else DEFAULT_POPUP_NUM
	for c in range(count):
		var popup_instance = WINDOW_SCENE.instantiate()
		popup_instance.set_up("default_window", "Error", true)
		add_child(popup_instance)
		if not popup_instance.is_node_ready():
			await popup_instance.ready
		var spawn_maximum : Vector2 = get_viewport().get_visible_rect().size - popup_instance.dimensions
		var spawn_pos = Vector2(randf_range(0, spawn_maximum.x), randf_range(0, spawn_maximum.y))
		popup_instance.position = spawn_pos
		popup_instance.position = spawn_pos
		await RenderingServer.frame_post_draw
