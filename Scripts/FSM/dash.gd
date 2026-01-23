class_name PlayerDash
extends State

@export var dashSpeed: float = 800.0
@export var dashDuration: float = 0.2
var dashDirection: Vector2 = Vector2.ZERO
var inputDir = Input.get_axis("left", "right")

func enter() -> void:
	player.animNode = "dash"
	
	if inputDir!= 0:
		dashDirection = Vector2(sign(inputDir), 0)
	else:
		dashDirection = Vector2(player.visuals.scale.x, 0)
	
	player.visuals.scale.x = dashDirection.x
	
	player.velocity = dashDirection * dashSpeed
	
	await get_tree().create_timer(dashDuration).timeout
	_on_dash_finished()

func physics_update(_delta: float) -> void:
	player.velocity = dashDirection * dashSpeed
	player.move_and_slide()

func _on_dash_finished() -> void:
	if not player.is_on_floor():
		transitioned.emit("Air")
	else:
		transitioned.emit("Run" if inputDir!= 0 else "Idle")
