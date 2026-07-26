class_name LoadingBar
extends Control

signal finished
signal stopped

@onready var progress_bar : ProgressBar = $ProgressBar
var stop_at : int = -1
var started : bool = false
var paused : bool = false


func _ready() -> void:
	reset()


func reset():
	started = false
	progress_bar.visible = false
	progress_bar.value = 0
	$Label.visible = false
	$Timer.stop()


func start():
	started = true
	progress_bar.visible = true
	progress_bar.value = 0
	$Timer.start()
	$Label.visible = true


func _process(delta: float) -> void:
	if not started:
		return
	if progress_bar.value == stop_at:
		return
	if stop_at != -1 and progress_bar.value > stop_at:
		progress_bar.value = stop_at
		return
	progress_bar.value += delta


func _on_progress_bar_gui_input(event: InputEvent) -> void:
	if not event.is_action_pressed("left_click"):
		return
	if not started:
		return
	if progress_bar.value == stop_at:
		return
	if stop_at != -1 and progress_bar.value > stop_at:
		progress_bar.value = stop_at
		return
	progress_bar.value += 1


func _on_progress_bar_value_changed(value: float) -> void:
	if value == stop_at:
		stopped.emit()
	if value == 100:
		finished.emit()
		$Timer.stop()
		$Label.text = "Uploaded!"


func _on_timer_timeout() -> void:
	if $Label.text == "Uploading File...":
		$Label.text = "Click Bar to Load Faster"
	else:
		$Label.text = "Uploading File..."
