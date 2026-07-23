extends Control

@onready var player := $Player

# 10 to 140
var pos: float = 10

@export var player_speed = 10.0
@export var bullet_speed = 20.0
@export var enemy_speed = 5.0

@export var bullet: PackedScene
@export var enemy: PackedScene

var enemies: Array[Area2D]

func _ready() -> void:
	for i in range(0, 8):
		var new_enemy = enemy.instantiate()
		add_child(new_enemy)
		new_enemy.position.y = 50
		new_enemy.position.x = 60 + 40 * i
		new_enemy.set_speed(enemy_speed)
		enemies.append(new_enemy)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		shoot()

func shoot():
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.position = Vector2(player.position.x, player.position.y - 20)
	new_bullet.set_speed(bullet_speed)

func _physics_process(_delta: float) -> void:
	pos += Input.get_axis("left", "right") * player_speed
	pos = clamp(pos, 60, 350)
	player.position.x = round(pos)
