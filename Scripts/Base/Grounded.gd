extends State
class_name GroundedState

func physics_update(_delta: float) -> void:
	if !player.is_on_floor():
		transitioned.emit("Air")
		return
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = -470.0
		transitioned.emit("Air")
	
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
		
	if Input.is_action_just_pressed("dash") && player.dashCooldown <= 0:
		transitioned.emit("Dash")
		return
	
	if player.is_on_floor():
		if Input.get_axis("left", "right") != 0:
			transitioned.emit("Run")
		else:
			transitioned.emit("Idle")
