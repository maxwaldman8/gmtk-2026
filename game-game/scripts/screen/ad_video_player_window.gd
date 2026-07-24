extends Control

@export var ad_percentages: Array[float]
@export var ads: Array[VideoStream]
@export var skip_time_s = 3.0
@export var indicator_width = 27
@export var stop_indicator: PackedScene

var stop_indicators: Array[Control]
var saved_video_stream
var saved_percentage = 0
var ad_playing: bool = false

@onready var full_width = custom_minimum_size.x
@onready var indicator_width_percentage = indicator_width / full_width * 100.0
@onready var video := $VideoStreamPlayer
@onready var progress_bar := $VideoStreamPlayer/ProgressBar
@onready var time_left = $VideoStreamPlayer/ProgressBar/TimeLeft

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		video.paused = !video.paused
	if event.is_action_pressed("right") and !ad_playing:
		video.stream_position = clamp(video.stream_position + skip_time_s, 0, video.get_stream_length())

func _ready() -> void:
	ad_percentages.sort()
	for ad in ad_percentages:
		var new_indicator = stop_indicator.instantiate()
		add_child(new_indicator)
		stop_indicators.append(new_indicator)
		new_indicator.position.y = 515
		new_indicator.position.x = (ad / 100.0) * full_width

func _physics_process(_delta: float) -> void:
	var percentage: float = video.stream_position / video.get_stream_length() * 100.0
	progress_bar.value = percentage
	time_left.text = "Time Left: " + str(int(video.get_stream_length() - video.stream_position)) + "s"
	if ad_percentages.size() != 0:
		if !ad_playing and abs(percentage - ad_percentages[0]) < indicator_width_percentage / 2.0:
			saved_percentage = ad_percentages[0] + (indicator_width_percentage / 2.0)
			saved_video_stream = video.stream
			ad_playing = true
			video.stream = ads[0]
			for indicator in stop_indicators:
				indicator.visible = false
			video.paused = false
		elif percentage - ad_percentages[0] >= indicator_width_percentage / 2.0:
			ads.remove_at(0)
			ad_percentages.remove_at(0)
			stop_indicators.remove_at(0)

func _on_video_stream_player_finished() -> void:
	if ad_playing:
		video.stream = saved_video_stream
		video.stream_position = saved_percentage * video.get_stream_length()
		ad_playing = false
		ads.remove_at(0)
		ad_percentages.remove_at(0)
		stop_indicators.remove_at(0)
		for indicator in stop_indicators:
			indicator.visible = true
		video.play()
	else:
		get_parent().close()
