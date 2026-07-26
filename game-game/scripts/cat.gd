class_name Cat
extends Node3D

@export var locations : Array[Vector3]
@export var player : Node3D
var tween : Tween = null
var moving = false
static var flying = false
var index = 0
var nextStep : float = 0
var stillMesh : MeshInstance3D
var stepMesh : MeshInstance3D

func _ready() -> void:
	stillMesh = get_node("Cat2")
	stepMesh = get_node("Cat1")
	flying = false

func _process(_delta: float) -> void:
	if flying and locations[0].y < 0:
		for i in range(locations.size()):
			locations[i] += Vector3.UP * 3.6
	if tween == null or !tween.is_running():
		moving = false
	stillMesh.visible = !moving
	stepMesh.visible = moving
	if (flying and locations[index].distance_to(player.position) < 6.4) or (!flying and locations[index].distance_to(player.position) < 8.0) and !moving and player.position.y < 2.4:
		if !flying:
			moving = true
		var prevPos = fposmod(index - 1, locations.size())
		var nextPos = fposmod(index + 1, locations.size())
		if locations[prevPos].distance_to(player.position) > locations[nextPos].distance_to(player.position):
			index = prevPos
		else:
			index = nextPos
		look_at(locations[index], Vector3.UP, true)
		if tween != null and tween.is_running():
			tween.stop()
		tween = create_tween()
		tween.tween_property(self, "position", locations[index], 0.5)
		nextStep = Screen.time + 0.125
		tween.play()
		$Meow.play()
	elif moving:
		if Screen.time > nextStep:
			nextStep += 0.125
			stepMesh.scale.x *= -1 
