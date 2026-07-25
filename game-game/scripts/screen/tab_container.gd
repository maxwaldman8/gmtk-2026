extends TabContainer

@onready var tab_bar : TabBar = get_tab_bar()
@export var tab_add_button : Button
@export var line_edit : LineEdit

@onready var window : GameWindow = get_parent().get_parent()
const NEW_TAB_WEB_SCENE = preload("res://scenes/screen/windows/browser websites/new_tab_website.tscn")


func _ready() -> void:
	tab_bar.tab_close_display_policy = TabBar.CLOSE_BUTTON_SHOW_ALWAYS
	tab_bar.tab_close_pressed.connect(_on_tab_close_pressed)
	move_tab_add_button()
	tab_bar.current_tab = 0


func _on_tab_close_pressed(tab_index: int) -> void:
	# if is the last tab
	if get_child_count() == 1:
		window.close()
		return
	var child_to_remove = get_child(tab_index)
	if child_to_remove:
		child_to_remove.queue_free()
	move_tab_add_button()


func _get_tabs_width():
	var total_width: float = 0.0
	var count = tab_bar.get_tab_count()
	if count > 0:
		var first_rect = tab_bar.get_tab_rect(0)
		var last_rect = tab_bar.get_tab_rect(count - 1)
		total_width = (last_rect.position.x - first_rect.position.x) + last_rect.size.x
	return total_width


func move_tab_add_button():
	await RenderingServer.frame_post_draw
	tab_add_button.position.x = _get_tabs_width() + 8 + 3
	tab_add_button.visible = (get_child_count() < 4)


func _on_tab_add_button_pressed() -> void:
	var margin_cont = MarginContainer.new()
	margin_cont.add_theme_constant_override("margin_top", 40)
	add_child(margin_cont)
	var new_tab_instance = NEW_TAB_WEB_SCENE.instantiate()
	margin_cont.add_child(new_tab_instance)
	tab_bar.set_tab_title(get_tab_count() - 1, "New Tab")
	tab_bar.current_tab = get_tab_count() - 1
	move_tab_add_button()


func _on_tab_changed(tab: int) -> void:
	line_edit.text = get_child(tab).get_child(0).get_url()


func _on_line_edit_text_submitted(new_text: String) -> void:
	pass # Replace with function body.
