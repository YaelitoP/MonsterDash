extends State

@export var air_speed: float = 300.0
const V_THRESHOLD = 20.0 

func process_physics(delta: float) -> void:
	player.velocity.y += gravity * delta
	player.move_and_slide()
	if Input.is_action_just_pressed("dash"):
		transitioned.emit("Dash")
		return
	
	var direction = Input.get_axis("left", "right")
	player.velocity.x = direction * air_speed
	
	if direction!= 0:
		player.visuals.scale.x = sign(direction)
		
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
		
	if player.is_on_floor():
		if direction!= 0:
			transitioned.emit("Run")
		else:
			transitioned.emit("Idle")
