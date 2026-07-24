extends Control

@onready var login_page = $LoginPage
@onready var password_field = $LoginPage/VBoxContainer/VBoxContainer/PasswordField
@onready var wrong_password = $LoginPage/VBoxContainer/VBoxContainer/WrongPassword
@onready var countdown = $LoginPage/VBoxContainer/VBoxContainer/Countdown
@onready var messaging_page = $MessagingPage

var password: String

var countdown_time_left: float = 5.0

func set_password(new_password: String) -> void:
	password = new_password

func login() -> void:
	if password_field.text == password:
		login_page.visible = false
		messaging_page.visible = true
	else:
		wrong_password.visible = true

func _process(delta: float) -> void:
	if countdown_time_left <= 0:
		countdown.text = "Hint: Press Tab"
	else:
		countdown.text = str(int(ceil(countdown_time_left)))
		countdown_time_left -= delta
