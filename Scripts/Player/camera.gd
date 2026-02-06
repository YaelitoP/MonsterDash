extends Camera2D

@export_group("Follow Speeds")
@export var horizontal_speed: float = 7.0
@export var vertical_speed: float = 4.0 

@export_group("State Modifiers")
@export var dash_follow_mult: float = 0.8 

func _ready() -> void:
	set_as_top_level(true)
	global_position = get_parent().global_position

func _physics_process(delta: float) -> void:
	if not get_parent(): return
	
	var target_pos = get_parent().global_position
	var current_state = get_parent().stateName
	
	var speed_x = horizontal_speed
	var speed_y = vertical_speed
	
	match current_state:
		"dash":
			speed_x *= dash_follow_mult
		"air":
			speed_y = vertical_speed
		"wall":
			speed_x = horizontal_speed / 2
			
	global_position.x = lerp(global_position.x, target_pos.x, speed_x * delta)
	global_position.y = lerp(global_position.y, target_pos.y, speed_y * delta)
