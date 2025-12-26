extends State
class_name GroundedState

# Lógica común para CUALQUIER estado en el suelo
func process_physics(delta: float) -> void:
	# Si dejas de tocar el suelo, vas a FALL (si tuvieras ese estado)
	if not player.is_on_floor():
		transitioned.emit("Fall")
		return

	# Lógica de SALTO centralizada: no necesitas repetirla en Idle ni en Run
	if Input.is_action_just_pressed("ui_accept"):
		player.velocity.y = -400.0 # JUMP_VELOCITY
		transitioned.emit("Jump") # O el estado que tengas para saltar
