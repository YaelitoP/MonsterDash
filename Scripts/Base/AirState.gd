extends State
class_name AirState

func process_physics(delta: float) -> void:
	# Gravedad común para todos los estados aéreos
	player.velocity.y += gravity * delta
	
	# Transición a pared si detecta colisión lateral
	if player.is_on_wall_only():
		transitioned.emit("WallHung")
		
	# Si toca el suelo, decide si va a Idle o Run
	if player.is_on_floor():
		if Input.get_axis("left", "right") != 0:
			transitioned.emit("Run")
		else:
			transitioned.emit("Idle")
