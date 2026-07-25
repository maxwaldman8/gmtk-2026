class_name Cat
extends Node3D

@export var locations : Array[Vector3]
@export var player : Node3D
var tween : Tween
var moving = false
static var flying = false
var index = 0
var nextStep : float = 0
var stillMesh : MeshInstance3D
var stepMesh : MeshInstance3D

func _ready() -> void:
	stillMesh = get_node("Cat2")
	stepMesh = get_node("Cat1")
	tween = create_tween()

func _process(delta: float) -> void:
	if !tween.is_running():
		moving = false
	stillMesh.visible = !moving
	stepMesh.visible = moving
	if locations[index].distance_to(player.position) < 10.0 and !moving and player.position.y < 2.4:
		if !flying:
			moving = true
		var prevPos = fposmod(index - 1, locations.size())
		var nextPos = fposmod(index + 1, locations.size())
		if locations[prevPos].distance_to(player.position) > locations[nextPos].distance_to(player.position):
			index = prevPos
		else:
			index = nextPos
		look_at(locations[index], Vector3.UP, true)
		if tween.is_running():
			tween.stop()
		tween = create_tween()
		if flying:
			tween.tween_property(self, "position", locations[index] + Vector3.UP * 3.6, 0.5)
		else:
			tween.tween_property(self, "position", locations[index], 0.5)
		nextStep = Screen.time + 0.125
		tween.play()
	elif moving:
		if Screen.time > nextStep:
			nextStep += 0.125
			stepMesh.scale.x *= -1 
			
func fly_now() -> void:
	flying = true
