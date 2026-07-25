extends Control

@onready var player := $Player

# 10 to 140
var pos: float = 10

@export var player_speed = 0.02
@export var bullet_speed = 15.0
@export var enemy_speed = 2.0
@export var enemy_acceleration = 0.5
@export var cooldown_time = 0.4

@export var bullet: PackedScene
@export var enemy: PackedScene

var bullets: Array[Area2D]
var enemies: Array[Area2D]

var wave = 0

var cooldown_time_left = 0.0

func _ready() -> void:
	spawn_wave()

func spawn_wave() -> void:
	for i in range(0, 8):
		var new_enemy = enemy.instantiate()
		add_child(new_enemy)
		new_enemy.position.y = 50
		new_enemy.position.x = 60 + 40 * i
		enemies.append(new_enemy)
	wave += 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		shoot()

func shoot():
	if cooldown_time_left <= 0.0:
		var new_bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.position = Vector2(player.position.x, player.position.y - 20)
		bullets.append(new_bullet)
		cooldown_time_left = 0.4

func _physics_process(delta: float) -> void:
	if enemies.size() == 0:
		if wave < 3:
			spawn_wave()
			enemy_speed = 3.0 + wave * 0.5
		else:
			# Game won
			get_parent().close()
	$TasksRunning.text = str(enemies.size() + 8 * (3 - wave))
	cooldown_time_left = clamp(cooldown_time_left - delta, 0, cooldown_time)
	pos = pos + (clamp(get_local_mouse_position().x, 60, 350) - pos) * player_speed
	pos = clamp(pos, 60, 350)
	player.position.x = round(pos)
	var to_delete = []
	for i in range(0, bullets.size()):
		bullets[i].position.y -= bullet_speed
		for area in bullets[i].get_overlapping_areas():
			if to_delete.find(i) == -1:
				to_delete.append(i)
			enemies.remove_at(enemies.find(area))
			area.queue_free()
			enemy_speed += enemy_acceleration
		if bullets[i].position.y <= 0 and to_delete.find(i) == -1:
			to_delete.append(i)
	to_delete.sort_custom(func(a, b): return a > b)
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
		if enemies[i].position.y >= 550:
			# Game over
			get_parent().close()
