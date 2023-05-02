extends Path2D

@onready var mob_spawn = $MobSpawn

func _ready():
	$MobSpawn/AnimatedSprite2D.play()

func _process(delta):
	mob_spawn.progress += 1
