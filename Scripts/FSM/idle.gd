extends GroundedState

func enter() -> void:
	player.animations.play("stand")

func process_physics(delta: float) -> void:
	# Ejecutamos primero la lógica de Grounded (el salto y la caída)
	super.process_physics(delta)
	
	# Lógica específica de Idle: Frenar
	player.velocity.x = move_toward(player.velocity.x, 0, 300.0)
	player.move_and_slide()

	# Transición a Run
	if Input.get_axis("ui_left", "ui_right")!= 0:
		transitioned.emit("Run")
