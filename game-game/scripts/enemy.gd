extends Area2D

var going_right: bool = true

@onready var speed: float

func set_speed(new_speed: float):
	speed = new_speed

func _physics_process(delta: float) -> void:
	if going_right:
		position.x += speed
	else:
		position.x -= speed
	if position.x < 60:
		position.x = 60
		going_right = true
		position.y += 40
	elif position.x > 350:
		position.x = 350
		going_right = false
		position.y += 40
