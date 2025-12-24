extends RigidBody2D
@export var follow_strength := 60.0
@export var max_speed := 1200.0

func _physics_process(_delta):
	var target := get_global_mouse_position()
	var dir := target - global_position
	
	apply_central_force(dir*follow_strength)
	
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
