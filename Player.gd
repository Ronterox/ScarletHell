extends Area2D

signal hit

@export var speed = 0.5
var screen_size
var start_pos

func _ready():
	screen_size = get_viewport().size
	start_pos = Vector2(screen_size.x * 0.5, screen_size.y * 0.9)
	position = start_pos

func _process(_delta):
	var velocity = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	var anim = $AnimatedSprite2D
	if velocity.length() > 0:
		position += velocity.normalized() * speed
		anim.play("up" if velocity.y != 0 else "walk")
		anim.flip_v = velocity.y > 0
		anim.flip_h = velocity.x > 0
	else:
		anim.stop()

func start():
	show()
	position = start_pos
	$CollisionShape2D.disabled = false

func _on_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
