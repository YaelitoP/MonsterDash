extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func init(player: Player) -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.player = player
			child.transitioned.connect(_on_state_transition)
	
	if initial_state:
		current_state = initial_state
		current_state.enter()

func process_physics(delta: float) -> void:
	if current_state:
		current_state.process_physics(delta)

func process_input(event: InputEvent) -> void:
	if current_state:
		current_state.process_input(event)

func _on_state_transition(new_state_name: String) -> void:
	var new_state = states.get(new_state_name.to_lower())
	if new_state and new_state != current_state:
		current_state.exit()
		new_state.enter()
		current_state = new_state
