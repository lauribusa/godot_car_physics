class_name Helpers

static func get_point_velocity (rb: RigidBody3D, point: Vector3) -> Vector3:
	return rb.linear_velocity + rb.angular_velocity.cross(point - rb.global_transform.origin)
