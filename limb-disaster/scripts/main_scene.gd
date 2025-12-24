extends Node2D

@export var mob_scene: PackedScene
var score

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_score_timer_timeout():
	score += 1
	
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	print("Test")
	
func _on_mob_timer_timeout():
	#create a new instance of the mob scene
	var mob = mob_scene.instantiate()
	
	#chose a random location on path 2d
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	#set the mob's position to the random location
	mob.position = mob_spawn_location.position 
	
	#set the mob's direction to perpendicular to the path direction
	var direction = mob_spawn_location.rotation+PI/2
	
	#add some randomness to the direction
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	#choose the velocity for the mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	#spawn the mob by adding it to the main scene
	add_child(mob)

func _ready():
	new_game()
