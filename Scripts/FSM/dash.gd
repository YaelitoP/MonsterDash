class_name PlayerDash
extends State

@export var dash_speed: float = 800.0
@export var dash_duration: float = 0.2
var dash_direction: Vector2 = Vector2.ZERO

func enter() -> void:
	# 1. Guardar la dirección: Priorizar input, si no hay, usar orientación del sprite
	var input_dir = Input.get_axis("ui_left", "ui_right")
	if input_dir!= 0:
		dash_direction = Vector2(input_dir, 0)
	else:
		# Si no hay input, dash hacia donde mira el personaje
		var face_dir = -1 if player.animations.flip_h else 1
		dash_direction = Vector2(face_dir, 0)
	
	# 2. Aplicar velocidad inicial alta
	player.velocity = dash_direction * dash_speed
	player.animations.play("dash")

	# 3. Usar un temporizador (await) para finalizar el dash
	await get_tree().create_timer(dash_duration).timeout
	_on_dash_finished()

func physics_update(_delta: float) -> void:
	# 4. Ignorar gravedad: Sobrescribimos la velocidad constantemente para 
	# evitar que la gravedad (u otras fuerzas) afecten la trayectoria.
	player.velocity = dash_direction * dash_speed
	player.move_and_slide()

func _on_dash_finished() -> void:
	# 5. Retorno inteligente: Si sigue en el aire, vuelve a Air, si no, a Idle/Run
	if not player.is_on_floor():
		transitioned.emit("Air")
	else:
		var input_dir = Input.get_axis("left", "right")
		if input_dir!= 0:
			transitioned.emit("Run")
		else:
			transitioned.emit("Idle")
