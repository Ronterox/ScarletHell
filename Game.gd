extends Node2D

@export var mob_scene: PackedScene
@onready var spawner = $MobSpawnPath/MobSpawn
@onready var hud: HUD = $HUD
@onready var music = $Music
var score

func set_score(val):
	score = val
	hud.update_score(score)

func new_game():
	set_score(0)
	
	music.play()
	
	$StartTimer.start()
	$Player.start()
	
	get_tree().call_group("mobs", "queue_free") # Delete all mobs

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	
	music.stop()
	$DeathSound.play()

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func _on_score_timer_timeout():
	set_score(score + 1)

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
	hud.show_game_over()

func _on_hud_start_game():
	new_game()
	hud.show_message("Dodge the\n Youkai!")
