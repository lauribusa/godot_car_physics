extends Camera3D

@onready var car : Node3D = get_node("/root/Main/RigidBody3D")

func _ready() -> void:
	var main = get_node("/root/Main")
	main.cameras.append(self)
	look_at(car.global_position)

func _process(delta: float) -> void:
	if current:
		look_at(car.global_position)
