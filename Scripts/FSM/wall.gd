extends WallState

@export_group("Física de Muro")
@export var slideGravity: float = 550.0

@export_group("Salto de Pared")
@export var wallJumpPushback: float = 400.0 
@export var wallJumpForce: float = -350.0

@export_group("Detección")
@export var wallShapeCast: ShapeCast2D
@export var wallOffsetCorrection: float = 6

var wallDir : float = 0.0

func enter() -> void:
	player.animNode = "wallSlide"
	player.velocity.x = 0


func physics_update(delta: float) -> void:
	wallShapeCast.force_shapecast_update()
	player.velocity.y = move_toward(player.velocity.y, slideGravity, slideGravity * delta)
	player.move_and_slide()
	
	if !wallShapeCast.is_colliding() or player.is_on_floor():
		transitioned.emit("Idle" if player.is_on_floor() else "Air")
		return
		
	wallDir = -sign(wallShapeCast.get_collision_normal(0).x)
	player.visuals.position.x = wallDir * wallOffsetCorrection
	player.visuals.scale.x = -wallDir
	

	if Input.is_action_just_pressed("jump"):
		player.velocity.x = -wallDir * wallJumpPushback
		player.velocity.y = wallJumpForce
		player.wallJumpInertia = 1.0 
		transitioned.emit("Air")
		return

func exit() -> void:
	# IMPORTANTE: Resetear la posición al salir del estado de pared
	player.visuals.position.x = 0
