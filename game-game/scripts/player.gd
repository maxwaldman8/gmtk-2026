extends CharacterBody3D


@export var SPEED = 7.0
@export var SPRINT_SPEED = 14.0
@export var JUMP_VELOCITY = 4.5

@export var sensitivity = 0.005

@onready var camera := $Camera3D
@onready var raycast := $Camera3D/RayCast3D

@export var screen: Control
@export var gui: CanvasLayer

var viewing_vector: bool = false
var active_layer: CanvasLayer
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if !viewing_vector:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			if event is InputEventMouseMotion:
				self.rotate_y(-event.relative.x * sensitivity)
				camera.rotate_x(-event.relative.y * sensitivity)
				camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(60))
		if event.is_action_pressed("left_click"):
			handle_raycast()

func handle_raycast():
	if raycast.is_colliding():
		var area: Node3D = raycast.get_collider()
		if area == null: pass
		match area.name:
			"ScreenArea":
				switch_to_screen()
			"AlarmArea":
				if area.visible:
					area.visible = false
					var sound : AudioStreamPlayer = area.get_parent().get_parent().get_node("Boom")
					sound.play()
					area.get_parent().get_parent().explode()
					area.get_parent().get_parent().get_node("CPUParticles3D").emitting = true
					area.get_parent().get_parent().get_node("CPUParticles3D2").emitting = true
					await get_tree().create_timer(0.0625).timeout
					area.get_parent().get_node("OmniLight3D").light_energy = 7.0
					await get_tree().create_timer(0.0625).timeout
					area.get_parent().get_node("OmniLight3D").light_energy = 5.0
					await get_tree().create_timer(0.0625).timeout
					area.get_parent().get_node("OmniLight3D").light_energy = 3.0
					await get_tree().create_timer(0.0625).timeout
					area.get_parent().get_node("OmniLight3D").light_energy = 1.0
					await get_tree().create_timer(0.0625).timeout
					area.get_parent().get_parent().get_node("CPUParticles3D").emitting = false
					area.get_parent().get_parent().get_node("CPUParticles3D2").emitting = false
					area.get_parent().queue_free()
			"DriveArea":
				area.get_parent().queue_free()
				var drive: MeshInstance3D = get_parent().get_node("Room/Drive2")
				drive.visible = true
				var tween = create_tween()
				tween.tween_property(drive, "position", Vector3(3.9, 0.8, -0.40), 0.5)
				tween.tween_property(drive, "position", Vector3(3.9, 0.0, -0.40), 0.5)
				tween.tween_property(drive, "position", Vector3(3.9, 0.0, -0.60), 1.0)
				tween.play()
				await get_tree().create_timer(2).timeout
				screen.insert_drive()
			"PasswordNoteArea":
				viewing_vector = true
				active_layer = screen.password_note
				active_layer.visible = true
				gui.visible = false
			"TVNoteArea":
				viewing_vector = true
				active_layer = screen.tv_note
				active_layer.visible = true
				gui.visible = false
			"CatBowlArea":
				viewing_vector = true
				active_layer = screen.cat_bowl
				active_layer.visible = true
				gui.visible = false

func switch_to_screen():
	get_tree().root.get_node("Room").get_node("RealMusic").volume_db = -80
	get_tree().root.get_node("Room").get_node("DigitalMusic").volume_db = 0
	self.process_mode = Node.PROCESS_MODE_DISABLED
	gui.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	screen.get_parent().get_parent().visible = true
	screen.set_focus_mode(Control.FOCUS_CLICK)
	screen.grab_focus()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !viewing_vector:
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("left", "right", "forward", "backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if Input.is_action_pressed("sprint"):
			if direction:
				velocity.x = direction.x * SPRINT_SPEED
				velocity.z = direction.z * SPRINT_SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPRINT_SPEED)
				velocity.z = move_toward(velocity.z, 0, SPRINT_SPEED)
		else:
			if direction:
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
	else:
		if Input.is_action_just_pressed("escape_screen"):
			active_layer.visible = false
			gui.visible = true
			viewing_vector = false
