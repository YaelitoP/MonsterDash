extends CharacterBody2D
class_name Player

@onready var stateMachine: StateMachine = $FSM
@onready var animTree: AnimationTree = $AnimationTree
@onready var visuals: Marker2D = $Visuals
@onready var animPlayback: AnimationNodeStateMachinePlayback
@export var inertiaDecay: float = 3.0
@export var slowClimbFactor: float = 0.7
@export var speed: float = 260.0
@export var safePositionCooldown: float = 0.5
@export var respawnMargin_x: float = 15.0
@export var respawnMargin_y: float = -5

var lastDir: float = 1.0
var stateName: String = "idle"
var animNode: String = "idle"
var wallJumpInertia: float = 0.0
var lastSafePosition: Vector2 = Vector2.ZERO
var safePositionTimer: float = 0.0
var dashCooldown: float = 0.0
func _ready() -> void:
	animPlayback = animTree.get("parameters/playback")
	stateMachine.init(self)

func _physics_process(delta: float) -> void:
	if dashCooldown > 0:
		dashCooldown -= delta
	stateMachine.process_physics(delta)
	if is_on_floor():
		safePositionTimer += delta
		if safePositionTimer >= safePositionCooldown:
			lastSafePosition = global_position
	else:
		safePositionTimer = 0.0
		
func respawn_to_safety() -> void:
	set_physics_process(false)
	
	var safety_backstep = -lastDir * respawnMargin_x
	var tween = create_tween().set_parallel(false)
	
	velocity = Vector2.ZERO
	
	tween.tween_property(visuals, "modulate:a", 0.0, 0.15)
	if lastSafePosition != Vector2.ZERO:
		global_position.x = lastSafePosition.x + safety_backstep
		global_position.y = lastSafePosition.y + respawnMargin_y
	
	tween.tween_callback(func():stateMachine.current_state = stateMachine.states.idle)
	tween.tween_property(visuals, "modulate:a", 1.0, 0.2)
	tween.tween_callback(func(): set_physics_process(true))

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("MAPLIMIT"):
		call_deferred("respawn_to_safety")
