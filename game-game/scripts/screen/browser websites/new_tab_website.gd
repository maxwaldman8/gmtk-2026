class_name NewTabWebsite
extends BrowserWebsite

@export var background : ColorRect
static var bookmarked_websites : PackedStringArray = ["turn"]
const url = ""


func _ready() -> void:
	background.size = Vector2(482, 481)
	size = Vector2(482, 481)


func get_url():
	return url
