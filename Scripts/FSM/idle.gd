extends GroundedState

func enter() -> void:
	player.velocity.x = 0
	player.animNode = "idle"

func physics_update(delta: float) -> void:
	player.move_and_slide()
	if Input.is_action_just_pressed("dash"):
		transitioned.emit("Dash")
		return
		
	super.physics_update(delta)
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
	if Input.get_axis("left", "right") != 0:
		transitioned.emit("Run")
