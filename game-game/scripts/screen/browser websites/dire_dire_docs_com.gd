class_name DireDireDocsComWebsite
extends BrowserWebsite

const url = "dirediredocs.com"
const tab_name = "Dire Dire Docs"

func get_url():
	return url

func _on_log_in_button_pressed() -> void:
	if $LoginPage/PasswordField.text == get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().english_password:
		$LoginPage.visible = false
		$Essay.visible = true


func _on_download_button_pressed() -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().download_english_essay()
