class_name WindowLayer
extends CanvasLayer


func add_to_window_list(window_instance : GameWindow):
	add_child(window_instance)
	await window_instance.ready
	print(window_instance.dimensions)


func move_window_to_front(window: GameWindow):
	move_child(window, -1)
