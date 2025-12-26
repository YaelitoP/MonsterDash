extends CharacterBody2D
class_name Player

@onready var state_machine: StateMachine = $FSM
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var visuals: Marker2D = $Visuals

var anim_playback: AnimationNodeStateMachinePlayback
func _ready() -> void:
	# Inicializamos la máquina pasando una referencia del jugador a los estados
	anim_playback = anim_tree.get("parameters/playback")
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
