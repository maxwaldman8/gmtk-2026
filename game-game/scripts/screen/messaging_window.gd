class_name MessagingWindow
extends Control

@onready var login_page = $LoginPage
@onready var password_field = $LoginPage/VBoxContainer/VBoxContainer/PasswordField
@onready var wrong_password = $LoginPage/VBoxContainer/VBoxContainer/WrongPassword
@onready var countdown = $LoginPage/VBoxContainer/VBoxContainer/Countdown
@onready var messaging_page = $MessagingPage

@export var message_box_holder : VBoxContainer
@onready var message_box_list = message_box_holder.get_children()
@export var option1_button : Button
@export var option2_button : Button
@export var download_button : Button
var current_message = 0
static var finished_dialog : bool = false

var password: String

var countdown_time_left: float = 5.0

func _ready() -> void:
	password = get_parent().get_parent().get_parent().messaging_password
	login_page.visible = true
	messaging_page.visible = false

func login() -> void:
	if password_field.text == password:
		login_page.visible = false
		messaging_page.visible = true
		update_options()
	else:
		wrong_password.visible = true

func _process(delta: float) -> void:
	if countdown_time_left <= 0:
		countdown.text = "Hint: Press Tab"
	else:
		countdown.text = str(int(ceil(countdown_time_left)))
		countdown_time_left -= delta


func set_all_buttons(to_visible: bool):
	option1_button.visible = to_visible
	option2_button.visible = to_visible


func update_options(message_received: String = ""):
	var options = MessageDialog.get_options_to(message_received)
	option1_button.text = options[0]
	option2_button.text = options[1]


func get_response():
	var return_message = MessageDialog.get_response_to(message_box_list[current_message - 1].message)
	message_box_list[current_message].visible = true
	message_box_list[current_message].message = return_message
	current_message += 1
	if MessageDialog.is_bad_end(return_message):
		finished_dialog = true
		return
	if MessageDialog.is_good_end(return_message):
		finished_dialog = true
		download_button.visible = true
		return
	set_all_buttons(true)
	update_options(return_message)


func _on_option_1_pressed() -> void:
	message_box_list[current_message].visible = true
	message_box_list[current_message].message = option1_button.text
	current_message += 1
	set_all_buttons(false)
	get_response()


func _on_option_2_pressed() -> void:
	message_box_list[current_message].visible = true
	message_box_list[current_message].message = option2_button.text
	current_message += 1
	set_all_buttons(false)
	get_response()


func _on_download_button_pressed() -> void:
	download_button.disabled = true
	download_button.text = "Downloaded to Desktop!"
	get_tree().get_first_node_in_group("lab_data_app").visible = true
