extends RigidBody2D

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random() #pick a random animation for the enemy
	$AnimatedSprite2D.play() #play chosen animation
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
