extends RigidBody2D

@export var strength := 120.0   # pull power (increase if weak)
@export var damping := 18.0     # removes shaking (increase if jittery)
@export var max_speed := 1400.0

func _physics_process(delta: float) -> void:
	var target := get_global_mouse_position()
	var to_target := target - global_position

	# spring force + damping
	var force := to_target * strength - linear_velocity * damping
	apply_central_force(force)

	# clamp speed
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
