extends State
class_name PlayerDash

@export var dash_duration: float = 0.2
@export var dash_speed: float = 800.0

func enter() -> void:
	player.animations.play("dash")
	# Obtenemos la dirección del input o usamos la dirección actual del sprite
	var dir = Input.get_axis("left", "right")
	if dir == 0: dir = 1 if not player.animations.flip_h else -1
	
	player.velocity = Vector2(dir * dash_speed, 0) # Ignora gravedad en Y
	
	# Finaliza el dash tras un tiempo determinado
	await player.get_tree().create_timer(dash_duration).timeout
	_finish_dash()

func _finish_dash():
	if player.is_on_floor():
		transitioned.emit("Idle")
	else:
		transitioned.emit("Fall")
