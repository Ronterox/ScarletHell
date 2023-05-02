extends Node2D

@export var mob_scene: PackedScene
@onready var spawner = $MobSpawnPath/MobSpawn
var score

func _ready():
	new_game()
	
func new_game():
	score = 0
	$StartTimer.start()
	$Player.start()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func _on_score_timer_timeout():
	score += 1

func _on_mob_timer_timeout():
	var mob: Mob = mob_scene.instantiate()
	mob.position = spawner.position
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(mob.get_angle_to($Player.position)) * (randi() % 4 + 1)
	
	add_child(mob)

func _on_start_timer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()

func _on_player_hit():
	game_over()
