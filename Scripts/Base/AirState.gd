extends State
class_name AirState

func physics_update(delta: float) -> void:
	player.velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("dash") && player.dashCooldown <= 0:
		transitioned.emit("Dash")
		return
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
	if player.is_on_floor():
		if Input.get_axis("left", "right") != 0:
			transitioned.emit("Run")
		else:
			transitioned.emit("Idle")
