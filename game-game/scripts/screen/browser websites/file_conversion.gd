class_name FileConversionWebsite
extends BrowserWebsite

const url = "fileconversiondocx2pdfnotpdf2txt.org"
const tab_name = "File Converter"

var download_time_left: float = 5.0
var countdown_started = false

func get_url():
	return url

func _process(delta: float) -> void:
	if countdown_started:
		if download_time_left > 0:
			download_time_left -= delta
			$DownloadButton.text = "Download in " + str(floor(download_time_left)) + ".."
		else:
			$DownloadButton.text = "Download"

func _on_convert_file_button_pressed() -> void:
	countdown_started = true
	$DownloadButton.visible = true
	$DownloadNowButton.visible = true

func _on_download_button_pressed() -> void:
	if download_time_left <= 0:
		get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().download_pdf()
		$DownloadButton.text = "Downloaded!"

func _on_download_now_button_pressed() -> void:
	get_parent().get_parent().switch_tab("freelogotshirts.tk")
