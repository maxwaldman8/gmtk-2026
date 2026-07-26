class_name ScamWebsite
extends BrowserWebsite

const url = "freelogotshirts.tk"
const tab_name = "FR33SH1RT$$$$$$$$"

var time_left: float = 1.0

func get_url():
	return url
	
	$Button.add_theme_color_override("font_color", Color.GREEN)

func _process(delta: float) -> void:
	if time_left <= 0:
		time_left = 1.0
		if $Button.get_theme_color("font_color") == Color.GREEN:
			$Button.add_theme_color_override("font_color", Color.RED)
		else:
			$Button.add_theme_color_override("font_color", Color.GREEN)
	time_left -= delta
