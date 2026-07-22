extends Control

var dimensions : Vector2i


func set_up(w_dimensions: Vector2i = Vector2i(50, 50)):
	pass


func _on_x_button_pressed() -> void:
	# closing animation?
	queue_free()
