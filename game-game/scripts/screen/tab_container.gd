extends TabContainer

@onready var tab_bar : TabBar = get_tab_bar()
@export var tab_add_button : Button

var window : GameWindow
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
	await RenderingServer.frame_post_draw
	move_tab_add_button()


func _get_tabs_width():
	var total_width: float = 0.0
	var count = tab_bar.get_tab_count()
	if count > 0:
		var first_rect = tab_bar.get_tab_rect(0)
		var last_rect = tab_bar.get_tab_rect(count - 1)
		total_width = (last_rect.position.x - first_rect.position.x) + last_rect.size.x
	print(total_width)
	return total_width


func move_tab_add_button():
	await get_tree().process_frame
	tab_add_button.position.x = _get_tabs_width() + 8 + 3
	tab_add_button.visible = (get_child_count() < 4)


func _on_tab_add_button_pressed() -> void:
	var margin_cont = MarginContainer.new()
	margin_cont.add_theme_constant_override("margin_top", 40)
	add_child(margin_cont)
	var new_tab_instance = NEW_TAB_WEB_SCENE.instantiate()
	margin_cont.add_child(new_tab_instance)
	tab_bar.set_tab_title(get_tab_count() - 1, "New Tab")
	move_tab_add_button()
