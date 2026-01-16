extends State

@export_group("Física de Muro")
@export var slideGravity: float = 150.0
@export var wallFriction: float = 800.0 # Cuánto frena la velocidad hacia arriba
@export var climbSpeed: float = 240.0

@export_group("Salto de Pared")
@export var wallJumpPushback: float = 500.0 # Fuerza horizontal hacia afuera
@export var wallJumpForce: float = -450.0

@export_group("Detección")
@export var ledgeCheck: RayCast2D

func process_physics(delta: float) -> void:
	# 1. MOVER PRIMERO: Actualiza normales y colisiones del frame actual [1, 2]
	player.move_and_slide()

	# 2. SALIDA: Si no hay pared, volvemos al aire
	if not player.is_on_wall_only():
		transitioned.emit("Air")
		return

	var wallNormal = player.get_wall_normal()
	var wallDir = -wallNormal.x # 1 si la pared está a la derecha, -1 a la izquierda

	# 3. LÓGICA DE SALTO (Evita escalado infinito)
	if Input.is_action_just_pressed("jump"):
		# Aplicamos un impulso fuerte alejando al jugador de la pared 
		player.velocity.x = wallNormal.x * wallJumpPushback
		player.velocity.y = wallJumpForce
		transitioned.emit("Air")
		return

	# 4. FRICCIÓN DE SUBIDA: Si el jugador llega con inercia hacia arriba, la frenamos rápido
	if player.velocity.y < 0:
		player.velocity.y = move_toward(player.velocity.y, 0, wallFriction * delta)

	if not ledgeCheck.is_colliding() and player.velocity.y > -50:
		_handle_ledge_interaction(delta, wallDir )
		return
		
	var input_dir = Input.get_axis("left", "right")
	
	
	if sign(input_dir) == wallDir or input_dir == 0:
		player.velocity.y = move_toward(player.velocity.y, slideGravity, slideGravity * delta)
		player.state_name = "wallSlide"
	else:
		transitioned.emit("Air")

	if player.is_on_floor():
		transitioned.emit("Idle")

func _handle_ledge_interaction(_delta: float, wallDir ) -> void:
	player.visuals.scale.x = wallDir  
	player.velocity = Vector2.ZERO
	player.state_name = "wallHung"

	if Input.is_action_pressed("up"):
		player.state_name = "wallClimb"
		player.velocity.y = -climbSpeed
	elif Input.is_action_pressed("crounch"):
		transitioned.emit("Air")
