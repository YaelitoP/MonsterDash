extends State
class_name WallState

func process_physics(_delta: float) -> void:
	if not player.is_on_wall():
		transitioned.emit("Fall")
	
	if player.is_on_floor():
		transitioned.emit("Idle")
