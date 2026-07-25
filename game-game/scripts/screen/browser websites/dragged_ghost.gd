class_name DraggedGhost
extends Control

signal dropped_ghost

@export var collision : CollisionShape2D
var file_name : String
var in_drop_space : bool = false
var was_dropped : bool = false


func _ready() -> void:
	collision.disabled = true
