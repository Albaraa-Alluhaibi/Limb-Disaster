extends Area2D
signal hit #player will send out signal when it collides with enemy or surface

@export var speed = 400 #how fast player moves in pixels per second
var screen_size #size of game window
var moving = false
var velocity = Vector2.ZERO
	
#ready function is called when a node enters the scene tree
func _ready():
	#get_viewport_rect() gets the size 
	screen_size = get_viewport_rect().size
	#hide the player
	hide()
	
#used to reset the player when starting a new game
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
#_process() function is called every frame and updates the elements within the game
func _process(delta):
	#check for input
	if Input.is_action_pressed("MoveByMouse") and not moving:
		var mouse_pos = get_global_mouse_position()
		velocity = (mouse_pos - position)
		moving = true
	elif moving:
		var mouse_pos = get_global_mouse_position()
		velocity = (mouse_pos - position)
	
	#update velocity and play animation
	if velocity.length() > 0:
		velocity = velocity.normalized()* speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	#play appropriate animation
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
	#move in given direction
	if(abs((get_global_mouse_position() - position).length()) < 1):
		moving = false
		velocity = Vector2.ZERO
	position += velocity*delta
	position = position.clamp(Vector2.ZERO, screen_size)
	return

func _on_body_entered(_body):
	hide() #player disappears after being
	hit.emit()#signal is emitted when player hits enemy or obstacle
	#disable collision since we can't we can't change physics properties on a physics callback
	$CollisionShape2D.set_deferred("disabled", true)
