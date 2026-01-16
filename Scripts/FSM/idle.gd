extends GroundedState

func enter() -> void:
	player.velocity.x = 0
	

func process_physics(delta: float) -> void:
	if Input.is_action_just_pressed("dash"):
		transitioned.emit("Dash")
		return
		
	super.process_physics(delta)
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
	if Input.get_axis("left", "right") != 0:
		transitioned.emit("Run")
