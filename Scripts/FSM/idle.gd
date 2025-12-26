extends GroundedState

func enter() -> void:
	player.anim_playback.travel("idle")
	# Frenamos al jugador
	player.velocity.x = 0

func process_physics(delta: float) -> void:
	super.process_physics(delta)
	
	if Input.get_axis("left", "right")!= 0:
		transitioned.emit("Run")
	
	player.move_and_slide()
