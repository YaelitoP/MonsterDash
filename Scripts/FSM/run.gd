extends GroundedState

func enter() -> void:
	player.animations.play("run")

func process_physics(delta: float) -> void:
	super.process_physics(delta) # Importante: hereda el salto de Grounded
	
	# Lógica específica de Run: Moverse
	var direction = Input.get_axis("left", "right")
	if direction == 0:
		transitioned.emit("Idle")
	else:
		player.velocity.x = direction * 300.0
	
	player.move_and_slide()
