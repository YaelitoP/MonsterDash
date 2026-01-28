extends Node
class_name State

signal transitioned(new_state_path: String)

var player: Player
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter() -> void: pass
func exit() -> void: pass
func input_update(_event: InputEvent) -> void: pass
func physics_update(_delta: float) -> void: pass
