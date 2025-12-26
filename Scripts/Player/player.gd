extends CharacterBody2D
class_name Player

@onready var state_machine: StateMachine = $FSM
@onready var animations: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Inicializamos la máquina pasando una referencia del jugador a los estados
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
