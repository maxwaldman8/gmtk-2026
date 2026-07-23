extends Control

@onready var player := $Player

# 10 to 140
var pos: float = 10

@export var player_speed = 10.0
@export var bullet_speed = 5.0
@export var enemy_speed = 1.0

@export var bullet: PackedScene
@export var enemy: PackedScene

var bullets: Array[Area2D]
var enemies: Array[Area2D]

func _ready() -> void:
	for i in range(0, 8):
		var new_enemy = enemy.instantiate()
		add_child(new_enemy)
		new_enemy.position.y = 50
		new_enemy.position.x = 60 + 40 * i
		enemies.append(new_enemy)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		shoot()

func shoot():
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
	new_bullet.position = Vector2(player.position.x, player.position.y - 20)
	bullets.append(new_bullet)

func _physics_process(_delta: float) -> void:
	pos += Input.get_axis("left", "right") * player_speed
	pos = clamp(pos, 60, 350)
	player.position.x = round(pos)
	var to_delete = []
	for i in range(0, bullets.size()):
		bullets[i].position.y -= bullet_speed
		for area in bullets[i].get_overlapping_areas():
			to_delete.append(i)
			enemies.remove_at(enemies.find(area))
			area.queue_free()
		if bullets[i].position.y <= 0:
			to_delete.append(i)
	for i in to_delete:
		bullets[i].queue_free()
		bullets.remove_at(i)
	for i in range(0, enemies.size()):
		if enemies[i].going_right:
			enemies[i].position.x += enemy_speed
		else:
			enemies[i].position.x -= enemy_speed
		if enemies[i].position.x < 60:
			enemies[i].position.x = 60
			enemies[i].going_right = true
			enemies[i].position.y += 40
		elif enemies[i].position.x > 350:
			enemies[i].position.x = 350
			enemies[i].going_right = false
			enemies[i].position.y += 40
