class_name NewTabWebsite
extends BrowserWebsite

@export var background : ColorRect
static var bookmarked_websites : PackedStringArray = ["turn"]


func _ready() -> void:
	url = ""
	background.size = Vector2(482, 481)
	size = Vector2(482, 481)


func get_url():
	return super.get_url()
