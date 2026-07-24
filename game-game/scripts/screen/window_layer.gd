class_name WindowLayer
extends CanvasLayer


func add_to_window_list(window_instance):
	add_child(window_instance)


func move_window_to_front(window: GameWindow):
	move_child(window, -1)
