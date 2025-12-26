extends State
class_name WallState

func process_physics(_delta: float) -> void:
	# Si deja de tocar la pared, vuelve a caer
	if not player.is_on_wall():
		transitioned.emit("Fall")
	
	# Si toca el suelo mientras está en la pared
	if player.is_on_floor():
		transitioned.emit("Idle")
