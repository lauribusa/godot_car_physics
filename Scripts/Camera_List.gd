extends Node3D

var cameras : Array[Camera3D]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_page_up"):
		_next_camera()

func _next_camera():
	for c in cameras:
		if c.current:
			c.clear_current(true)
			break
