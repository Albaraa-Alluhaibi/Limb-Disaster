extends RigidBody2D
@export var radius := 25.0
@export var color := Color(1, 0, 0, 0.8)  # red

func _ready():
	queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, radius, color)
