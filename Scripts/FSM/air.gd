extends AirState

@export var air_speed: float = 300.0
@export var air_acceleration: float = 800.0 

func enter() -> void:
	player.animNode = "air"
	
func physics_update(delta: float) -> void:
	player.velocity.y += gravity * delta
	player.move_and_slide()
	if Input.is_action_just_pressed("dash"):
		transitioned.emit("Dash")
		return
		
	var direction = Input.get_axis("left", "right")
	var target_speed = direction * air_speed
	
	if player.wallJumpInertia > 0:
		var control_factor = (1.0 - player.wallJumpInertia) * 12.0 
		player.velocity.x = lerp(player.velocity.x, target_speed, control_factor * delta)
		player.wallJumpInertia = move_toward(player.wallJumpInertia, 0.0, player.inertiaDecay * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, target_speed, air_acceleration * delta)
	
	
	if direction != 0:
		player.visuals.scale.x = sign(direction)
	
	
	_check_transitions()

func _check_transitions() -> void:
	if player.is_on_wall_only():
		transitioned.emit("wall")
	elif player.is_on_floor():
		var input_x = Input.get_axis("left", "right")
		transitioned.emit("Run" if input_x != 0 else "Idle")
