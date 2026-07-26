extends Control

func _on_download_button_pressed() -> void:
	get_parent().get_parent().get_parent().download_dfs()
	$DownloadButton.text = "Downloaded!"
