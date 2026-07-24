extends Control

@onready var login_page = $LoginPage
@onready var password_field = $LoginPage/VBoxContainer/VBoxContainer/PasswordField
@onready var wrong_password = $LoginPage/VBoxContainer/VBoxContainer/WrongPassword
@onready var messaging_page = $MessagingPage

var password: String

func set_password(new_password: String) -> void:
	password = new_password

func login() -> void:
	if password_field.text == password:
		login_page.visible = false
		messaging_page.visible = true
	else:
		wrong_password.visible = true
