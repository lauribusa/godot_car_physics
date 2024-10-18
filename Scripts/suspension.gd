extends RayCast3D

@export var label: Label3D
@export var car_rb: RigidBody3D
@export var damping: float = 1.0
@export var tightness: float = 1.0
var compression_ratio: float
var force: float
var impact_normal: Vector3
var hit_point: Vector3

func _ready() -> void:
	var offset = car_rb.global_position - global_position
	print(self.name + str(offset) + " "+ str(position))

func _physics_process(delta: float) -> void:
	_get_collision_point()
	_get_collision_normal()
	_calculate_compression_ratio()
	force = _calculate_push_force_by_ratio()
	_apply_force()
	_print_compression_and_force()

func _apply_force() -> void:
	if !is_colliding():
		return
	car_rb.apply_force(Vector3(0.0, force, 0.0), self.position)

func _calculate_compression_ratio() -> void:
	if !is_colliding():
		compression_ratio = 0.0
		return
	compression_ratio = abs(global_position.y / hit_point.y)
	compression_ratio = snapped(compression_ratio, 0.01)

func _get_collision_point():
	if !is_colliding():
		return
	hit_point = get_collision_point()

func _get_collision_normal():
	if !is_colliding():
		return
	impact_normal = get_collision_normal()
# F = -kx - bv where k is the "tightness" of the spring, x is how much the spring is compressed, 
# b is the coefficient of damping, 
# and v is the velocity of the point at which you are applying the suspension force. 
# float distance = SuspensionDistance - hit.distance; 
# //This gets the distance the "string was pushed" in the context of this implementation
# //hit.distance is the raycast's distance to the hit point
# float force = -SuspensionStrength * distance + 
# (SuspensionDamping * carBody.GetPointVelocity(corner).y); 
# //the -bv had to be inverted for damping to work.
# //SuspensionStrength is a constant that represents "k", and SuspensionDamping is a constant that represents "b".
func _calculate_push_force_by_ratio() -> float:
	var point_velocity = Helpers.get_point_velocity(car_rb, global_position)
	var force: float = snapped((-tightness * compression_ratio) + (damping * point_velocity.y), 0.01)
	return abs(force)

func _print_compression_and_force() -> void:
	label.text = str(compression_ratio) + " ("+str(force)+")";
