extends RigidBody3D

const JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		linear_velocity.y = JUMP_VELOCITY

@export var debug: bool
@export var movement_behavior: Node3D
@export var suspensions: Array[RayCast3D]
@export_group("Speeds")
@export var acceleration: float = 1
@export var braking:float = 1.0
@export var torque:float = 1.0
@export_group("Suspensions")
@export var raycast_distance: float = 0.5
@export var tightness: float = 5.0
@export var damping: float = 4.0

@onready var label: Label = get_node("/root/Main/CanvasLayer/Control/Label")

func _ready() -> void:
	_update_suspension_values()

func _process(delta: float) -> void:
	if !debug:
		return
	_update_suspension_values()
	_update_movement_values()
	
func _update_movement_values():
	movement_behavior.speed = acceleration;
	movement_behavior.brake = braking;
	movement_behavior.torque = torque;

func _update_suspension_values():
	var debug_text = "tightness: %s \n" %tightness
	debug_text += "damping: %s \n" %damping
	debug_text += "max_distance: %s \n" %raycast_distance
	debug_text += "acceleration: %s \n" %acceleration
	debug_text += "braking: %s \n" %braking
	debug_text += "torque: %s \n" %torque
	debug_text += "weight: %s kg \n" %mass
	
	label.text = debug_text 
	for suspension in suspensions:
		suspension.target_position.y = -raycast_distance
		suspension.tightness = tightness
		suspension.damping = damping
