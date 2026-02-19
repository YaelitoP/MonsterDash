extends GroundedState

func enter() -> void:
	player.animNode = "run"
	
func physics_update(_delta: float) -> void:

	player.move_and_slide()
	if Input.is_action_just_pressed("dash"):
		transitioned.emit("Dash")
		return
	super.physics_update(_delta) 
	var direction = Input.get_axis("left", "right")
	
	if direction == 0:
		transitioned.emit("Idle")
		return
	else:
		player.visuals.scale.x = sign(direction)
		player.velocity.x = direction * player.speed
		
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
	

func handle_slope_physics():
	var current_speed = player.speed
	var floor_normal: Vector2
	if player.is_on_floor():
		floor_normal = player.get_floor_normal()
	
	if sign(player.velocity.x) != sign(floor_normal.x) and floor_normal.x != 0:
		current_speed *= player.slow_climb_factor
	
	return current_speed
