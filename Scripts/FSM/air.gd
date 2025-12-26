extends State
class_name AirState

@export var air_speed: float = 300.0
@export var jump_force: float = -400.0

func enter() -> void:
	# Si entramos a este estado desde el suelo (Idle/Run), aplicamos el impulso
	# Pero si venimos de un Dash aéreo, no queremos volver a saltar.
	if player.is_on_floor():
		player.velocity.y = jump_force

func physics_update(delta: float) -> void:
	# 1. Aplicar Gravedad
	player.velocity.y += gravity * delta
	
	# 2. Control Aéreo Horizontal
	var direction = Input.get_axis("left", "right")
	player.velocity.x = direction * air_speed
	
	# 3. MANEJO DE ANIMACIONES (Salto vs Caída)
	if player.velocity.y < 0:
		player.animations.play("jump")
	else:
		player.animations.play("fall")
	
	player.move_and_slide()

	# 4. TRANSICIÓN A DASH (Aéreo)
	if Input.is_action_just_pressed("dash"): # Asegúrate de tener "dash" en tu Input Map
		transitioned.emit("Dash")
		return

	# 5. TRANSICIÓN A PARED
	if player.is_on_wall_only():
		transitioned.emit("WallHung")
		return

	# 6. TRANSICIÓN AL SUELO
	if player.is_on_floor():
		if direction!= 0:
			transitioned.emit("Run")
		else:
			transitioned.emit("Idle")
