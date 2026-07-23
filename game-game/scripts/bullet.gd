extends Area2D

@onready var speed: float

func set_speed(new_speed: float):
	speed = new_speed

func _physics_process(_delta: float) -> void:
	position.y -= speed
	if position.y <= 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	# TODO: kill enemy
	pass
