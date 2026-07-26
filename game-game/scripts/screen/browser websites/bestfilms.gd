class_name BestFilmsWebsite
extends BrowserWebsite

const url = "bestfilms.net"
const tab_name = "Best Films"

func get_url():
	return url

func _on_download_button_pressed() -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().download_ad_video()
	$DownloadButton.text = "Downloaded!"
