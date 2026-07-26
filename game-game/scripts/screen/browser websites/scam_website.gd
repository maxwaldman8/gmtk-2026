class_name ScamWebsite
extends BrowserWebsite

const url = "freelogotshirts.tk"
const tab_name = "FR33SH1RT$$$$$$$$"

var time_left: float = 1.0

func get_url():
	return url
	
func _ready() -> void:
	$BuyButton.add_theme_color_override("font_color", Color.GREEN)

func _process(delta: float) -> void:
	if time_left <= 0:
		time_left = 1.0
		if $BuyButton.get_theme_color("font_color") == Color.GREEN:
			$BuyButton.add_theme_color_override("font_color", Color.RED)
		else:
			$BuyButton.add_theme_color_override("font_color", Color.GREEN)
	time_left -= delta


func _on_buy_button_pressed() -> void:
	match $SSN.text.to_lower():
		"1225":
			$Label2.text = "ooh cool easter egg"
		"1234":
			$Label2.text = "abcd"
		"0":
			$Label2.text = "thats not a social security number"
		"infinity":
			$Label2.text = "too high"
		"1159":
			$Label2.text = "great game you should play"
		"1148":
			$Label2.text = "great team you should alliance"
		"11024":
			$Label2.text = "excellent team you should DEFINITELY alliance"
			
