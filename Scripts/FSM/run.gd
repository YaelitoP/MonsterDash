extends GroundedState

func enter() -> void:
	player.animNode = "run"
	
func physics_update(_delta: float) -> void:
	player.move_and_slide()
	if Input.is_action_just_pressed("dash"):
		transitioned.emit("Dash")
		return
	super.physics_update(_delta) 
	var direction = Input.get_axis("left", "right")
	
	if direction == 0:
		transitioned.emit("Idle")
		return
	else:
		player.visuals.scale.x = sign(direction)
		player.velocity.x = direction * 260.0
		
	if player.is_on_wall_only():
		transitioned.emit("wall")
		return
