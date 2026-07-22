class_name WindowLayer
extends CanvasLayer

# later indices are above
var window_list : Array[GameWindow] = []


func add_to_window_list(window_instance):
	window_list.append(window_instance)
	add_child(window_instance)
	move_window_to_front(window_instance)


func move_window_to_front(window: GameWindow):
	var index = window_list.find(window)
	window_list.remove_at(index)
	window_list.append(window)
	for i in range(len(window_list)):
		window_list[i].z_index = i


func remove_window(window: GameWindow):
	var index = window_list.find(window)
	window_list.remove_at(index)
	for i in range(len(window_list)):
		window_list[i].z_index = i
