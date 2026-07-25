extends Control

func _ready() -> void:
	$TextureRect.texture = get_parent().get_parent().get_parent().english_password_1_texture

func _on_make_wallpaper_button_pressed() -> void:
	get_parent().get_parent().get_parent().set_wallpaper($TextureRect.texture)
