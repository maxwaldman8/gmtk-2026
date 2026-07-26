extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	$AudioStreamPlayer3D.play()
	await get_tree().create_timer(5).timeout
	$Room/Alarm.sound_on = true
	await get_tree().create_timer(9).timeout
	$AudioStreamPlayer3D.stop()
	$CanvasLayer/AnimationPlayer.play("open_eyes")
	await $CanvasLayer/AnimationPlayer.animation_finished
	var tween = create_tween()
	tween.tween_property($Camera3D, "rotation", Vector3(0, 0, 0), 3)
	tween.play()
	await get_tree().create_timer(4).timeout
	tween = create_tween()
	tween.tween_property($Camera3D, "rotation", Vector3(0, -PI/3.0, 0), 0.25)
	tween.play()
	await get_tree().create_timer(1).timeout
	tween = create_tween()
	tween.tween_property($Camera3D, "rotation", Vector3(0, -PI/3.0, -PI/12.0), 0.5)
	tween.play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
