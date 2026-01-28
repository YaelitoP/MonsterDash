extends CharacterBody2D
class_name Player

@onready var stateMachine: StateMachine = $FSM
@onready var animTree: AnimationTree = $AnimationTree
@onready var visuals: Marker2D = $Visuals
@onready var animPlayback: AnimationNodeStateMachinePlayback
@export var inertiaDecay: float = 3.0

var stateName: String = "idle"
var animNode: String = "idle"
var wallJumpInertia: float = 0.0

func _ready() -> void:
	animPlayback = animTree.get("parameters/playback")
	stateMachine.init(self)

func _physics_process(delta: float) -> void:
	stateMachine.process_physics(delta)
	
