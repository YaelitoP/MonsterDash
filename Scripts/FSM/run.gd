extends GroundedState

# Guardamos la última dirección para saber cuándo el jugador "volteó"
var last_direction: float = 0.0

func enter() -> void:
	# Al entrar a correr, le pedimos al árbol que viaje a la animación "run"
	player.anim_playback.travel("run")
	# Inicializamos la dirección actual
	last_direction = sign(Input.get_axis("left", "right"))
	
func process_physics(delta: float) -> void:
	super.process_physics(delta)
	var direction = Input.get_axis("left", "right")

	if direction == 0:
		transitioned.emit("Idle")
		return
	# Comprobamos si el AnimationTree está reproduciendo actualmente el "pivot"
	var current_node = player.anim_playback.get_current_node()
	if direction!= 0:
		# SOLO hacemos el flip si NO estamos haciendo el pivot
		# O si el pivot ya terminó de mostrarse
		if current_node!= "pivot":
			player.visuals.scale.x = sign(direction)
	# Disparamos el pivot si la dirección cambió
		if sign(direction)!= last_direction:
			player.anim_playback.travel("pivot")
			last_direction = sign(direction)
	player.velocity.x = direction * 300.0
	player.move_and_slide()
