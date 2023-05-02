extends CanvasLayer
class_name HUD

signal start_game
@onready var message = $MessageLabel
@onready var message_timer = $MessageTimer
@onready var start_button = $StartButton

func show_message(text, timer=true):
	message.text = text
	message.show()
	
	if timer:
		message_timer.start()
	

func show_game_over():
	show_message("Game Over")
	
	await message_timer.timeout
	
	show_message("Scarlet Hell", false)
	
	start_button.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()

func _on_message_timer_timeout():
	message.hide()
