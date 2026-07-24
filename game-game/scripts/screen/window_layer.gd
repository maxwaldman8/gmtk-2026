class_name WindowLayer
extends CanvasLayer


func add_to_window_list(window_instance : GameWindow):
	add_child(window_instance)
	if not window_instance.is_node_ready():
		await window_instance.ready
	var spawn_maximum : Vector2 = get_viewport().get_visible_rect().size - window_instance.dimensions
	var spawn_pos = Vector2(randf_range(0, spawn_maximum.x), randf_range(0, spawn_maximum.y))
	window_instance.position = spawn_pos


func move_window_to_front(window: GameWindow):
	move_child(window, -1)
