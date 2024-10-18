extends Node3D

@export var rb : RigidBody3D
var speed: float
var brake: float
var torque: float

func _process(delta: float) -> void:
	if(Input.is_action_pressed("ui_up")):
		position
		rb.apply_force(Vector3(0, 0, -1), position)
	if(Input.is_action_pressed("ui_down")):
		rb.apply_force(Vector3(0, 0, 1), position)
	if(Input.is_action_pressed("ui_left")):
		rb.apply_torque(Vector3(0, torque, 0))
	if(Input.is_action_pressed("ui_right")):
		rb.apply_torque(Vector3(0, -torque, 0))
