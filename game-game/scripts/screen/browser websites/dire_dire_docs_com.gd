class_name DireDireDocsComWebsite
extends BrowserWebsite

const url = "dirediredocs.com"
const tab_name = "Dire Dire Docs"

func get_url():
	return url

func _on_log_in_1_button_pressed() -> void:
	if $LoginPage1/PasswordField.text == get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().english_password:
		$LoginPage1.visible = false
		$LoginPage2.visible = true
	else:
		$LoginPage1/IncorrectPasswordLabel.visible = true

func _on_log_in_2_button_pressed() -> void:
	if $LoginPage2/NameField.text.to_lower() == get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().cat_name.to_lower():
		$LoginPage2.visible = false
		$Essay.visible = true
	else:
		$LoginPage2/IncorrectPasswordLabel.visible = true

func _on_download_button_pressed() -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().download_english_essay()
	$Essay/DownloadButton.text = "Downloaded!"
