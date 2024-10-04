extends CanvasLayer

# To anyone wondering what the 'bugfix' node is for. I really don't know. Without it, the speaker frame refuses to show up.

signal finished_speaking

var speed = 0.05
func type_dialog(text):
	%dialog_label.text = ""
	for charac in text:
		%dialog_label.text += charac
		await get_tree().create_timer(speed).timeout
	finished_speaking.emit()
	return

func set_speaker(text):
	%speaker_label.text = text

func set_color(color):
	%dialog_label.self_modulate = Color(color)

func skip():
	speed = 0.002
	await finished_speaking
	speed = 0.05
