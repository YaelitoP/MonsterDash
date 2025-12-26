extends Node
class_name State

signal transitioned(new_state_path: String)

var player: Player
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Métodos virtuales para ser sobreescritos
func enter() -> void: pass
func exit() -> void: pass
func process_input(_event: InputEvent) -> void: pass
func process_physics(_delta: float) -> void: pass
