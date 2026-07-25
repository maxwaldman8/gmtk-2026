class_name DireDireDocsEsWebsite
extends BrowserWebsite

const url = "dirediredocs.es"
const tab_name = "Muelles Terribles Terribles"

func get_url():
	return url

func _on_log_in_1_button_pressed() -> void:
	if $LoginPage1/PasswordField.text == get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().spanish_password:
		$LoginPage1.visible = false
		$LoginPage2.visible = true

func _on_log_in_2_button_pressed() -> void:
	if $LoginPage2/SurnameField.text.to_lower() == get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().cat_surname.to_lower():
		$LoginPage2.visible = false
		$Essay.visible = true

func _on_download_button_pressed() -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().download_spanish_essay()
