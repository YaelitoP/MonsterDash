extends GroundedState

func enter() -> void:
	player.velocity.x = 0
	player.animNode = "idle"

func physics_update(delta: float) -> void:
	player.move_and_slide()
	
	super.physics_update(delta)
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
	if Input.get_axis("left", "right") != 0:
		transitioned.emit("Run")
