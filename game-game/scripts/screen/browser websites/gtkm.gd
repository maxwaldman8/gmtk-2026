class_name GTKMWebsite
extends BrowserWebsite

const url = "gtkm.com"
const tab_name = "GTKM"

func get_url():
	return url

func _on_download_button_pressed() -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().download_question_video()
	$DownloadButton.text = "Downloaded!"
