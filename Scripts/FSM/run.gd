extends GroundedState

func enter() -> void:
	player.animNode = "run"
	
func physics_update(delta: float) -> void:
	player.move_and_slide()
	
	super.physics_update(delta) 
	var direction = Input.get_axis("left", "right")
	player.lastDir = direction
	if direction == 0:
		transitioned.emit("Idle")
		return
	else:
		player.visuals.scale.x = sign(direction)
		player.velocity.x = direction * player.speed
		

func handle_slope_physics():
	var current_speed = player.speed
	var floor_normal: Vector2
	if player.is_on_floor():
		floor_normal = player.get_floor_normal()
	
	if sign(player.velocity.x) != sign(floor_normal.x) and floor_normal.x != 0:
		current_speed *= player.slowClimbFactor
	
	return current_speed
