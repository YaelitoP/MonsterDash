class_name PlayerDash
extends State

@export var dash_speed: float = 800.0
@export var dash_duration: float = 0.2
var dash_direction: Vector2 = Vector2.ZERO

func enter() -> void:
	var input_dir = Input.get_axis("left", "right")
	if input_dir!= 0:
		dash_direction = Vector2(sign(input_dir), 0)
	else:
		dash_direction = Vector2(player.visuals.scale.x, 0)
	
	player.visuals.scale.x = dash_direction.x
	
	player.velocity = dash_direction * dash_speed
	
	player.anim_playback.travel("Dash")

	await get_tree().create_timer(dash_duration).timeout
	_on_dash_finished()

func process_physics(_delta: float) -> void:
	player.velocity = dash_direction * dash_speed
	player.move_and_slide()

func _on_dash_finished() -> void:
	if not player.is_on_floor():
		transitioned.emit("Air")
	else:
		var dir = Input.get_axis("left", "right")
		if dir!= 0:
			transitioned.emit("Run")
		else:
			transitioned.emit("Idle")
