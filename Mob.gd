extends RigidBody2D
class_name Mob

func _ready():
	var anim = $AnimatedSprite2D
	
	var mob_types = anim.sprite_frames.get_animation_names()
	anim.play(mob_types[randi() % mob_types.size()])

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
