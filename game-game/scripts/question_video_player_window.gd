extends Control

@export var question_percentages: Array[float]
@export var questions: Array[Control]
@export var skip_time_s = 5.0
@export var indicator_width = 27
@export var stop_indicator: PackedScene

var stop_indicators: Array[Control]
var on_question: bool = false

@onready var full_width = custom_minimum_size.x
@onready var indicator_width_percentage = indicator_width / full_width * 100.0
@onready var video := $VideoStreamPlayer
@onready var progress_bar := $VideoStreamPlayer/ProgressBar
@onready var time_left = $VideoStreamPlayer/ProgressBar/TimeLeft

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and !on_question:
		video.paused = !video.paused
	if event.is_action_pressed("right") and !on_question:
		video.stream_position = clamp(video.stream_position + skip_time_s, 0, video.get_stream_length())

func _ready() -> void:
	question_percentages.sort()
	for question in question_percentages:
		var new_indicator = stop_indicator.instantiate()
		add_child(new_indicator)
		stop_indicators.append(new_indicator)
		new_indicator.position.y = 515
		new_indicator.position.x = (question / 100.0) * full_width

func _physics_process(_delta: float) -> void:
	var percentage: float = video.stream_position / video.get_stream_length() * 100.0
	progress_bar.value = percentage
	time_left.text = "Time Left: " + str(int(video.get_stream_length() - video.stream_position)) + "s"
	if question_percentages.size() != 0:
		if !on_question and abs(percentage - question_percentages[0]) < indicator_width_percentage / 2.0:
			video.paused = true
			on_question = true
			questions[0].visible = true
			for indicator in stop_indicators:
				indicator.visible = false
			video.play()
		elif percentage - question_percentages[0] >= indicator_width_percentage / 2.0:
			questions.remove_at(0)
			question_percentages.remove_at(0)
			stop_indicators.remove_at(0)
			

func _on_video_stream_player_finished() -> void:
	get_parent().close()

func correct_answer() -> void:
	on_question = false
	questions[0].visible = false
	questions.remove_at(0)
	question_percentages.remove_at(0)
	stop_indicators.remove_at(0)
	for indicator in stop_indicators:
		indicator.visible = true
	video.paused = false

func reset() -> void:
	get_parent().close()
