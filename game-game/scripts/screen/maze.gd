extends Control

@onready var player := $Darkness/Player
@onready var end_tile: Area2D = $Darkness/EndTile

func _physics_process(_delta: float) -> void:
	if end_tile.get_overlapping_bodies().find(player) != -1:
		get_parent().get_parent().get_parent().finish_maze()
		get_parent().close()
	var vector_to_mouse: Vector2 = get_local_mouse_position() - player.position
	var dir: Vector2 = vector_to_mouse.normalized()
	var magnitude: float = vector_to_mouse.length()
	var force_magnitude = 1.0 / (pow(magnitude, 1.3)) * 700000.0
	if magnitude <= 50.0:
		force_magnitude = 0.0
	if magnitude >= 400.0:
		force_magnitude = 0.0
	player.apply_central_force(dir * force_magnitude)
