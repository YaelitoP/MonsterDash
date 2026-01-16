extends CharacterBody2D
class_name Player

@onready var state_machine: StateMachine = $FSM;
@onready var anim_tree: AnimationTree = $AnimationTree;
@onready var visuals: Marker2D = $Visuals;
@onready var animations: AnimationPlayer = $AnimationPlayer;
@onready var anim_playback: AnimationNodeStateMachinePlayback;

var state_name: String = "";

func _ready() -> void:
	anim_playback = anim_tree.get("parameters/playback");
	state_machine.init(self);

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event);

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta);
