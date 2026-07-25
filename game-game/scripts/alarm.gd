extends Node3D

var exploded = false
var nextBlink : float = 0
@export var alarmText : Label
var sound : AudioStreamPlayer

func _ready() -> void:
	sound = get_node("AlarmLoop")

func _process(_delta: float) -> void:
	if exploded:
		alarmText.visible = false
	else:
		if int(Screen.time / 60.0) < 56:
			alarmText.text = "11:" + str(int(Screen.time / 60.0))
			if Screen.time > nextBlink:
				nextBlink = int(Screen.time + 1)
				alarmText.visible = !alarmText.visible
		elif Screen.time > nextBlink:
			alarmText.text = "11:56"
			if !sound.playing:
				sound.play()
			nextBlink += 0.25
			alarmText.visible = !alarmText.visible
			

func explode() -> void:
	exploded = true
