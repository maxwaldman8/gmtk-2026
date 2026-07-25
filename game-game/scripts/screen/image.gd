extends Control



func _on_make_wallpaper_button_pressed() -> void:
	get_parent().get_parent().get_parent().set_wallpaper($TextureRect.texture)
