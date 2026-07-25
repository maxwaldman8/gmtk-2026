class_name LoadingBar
extends Control

signal finished

@onready var progress_bar : ProgressBar = $ProgressBar
var have_half_lock : bool = false
var started : bool = false


func _ready() -> void:
	reset()


func reset():
	started = false
	progress_bar.visible = false
	progress_bar.value = 0
	$Label.visible = false


func start():
	started = true
	progress_bar.visible = true
	progress_bar.value = 0
	$Timer.start()
	$Label.visible = true


func _process(delta: float) -> void:
	if not started:
		return
	if have_half_lock and progress_bar.value >= 50:
		return
	progress_bar.value += delta


func _on_progress_bar_gui_input(event: InputEvent) -> void:
	if not event.is_action_pressed("left_click"):
		return
	if not started:
		return
	if have_half_lock and progress_bar.value >= 50:
		return
	progress_bar.value += 1


func _on_progress_bar_value_changed(value: float) -> void:
	if value == 100:
		finished.emit()


func _on_timer_timeout() -> void:
	if $Label.text == "Uploading File...":
		$Label.text = "Click Bar to Load Faster"
	else:
		$Label.text = "Uploading File..."
