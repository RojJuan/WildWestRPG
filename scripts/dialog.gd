extends CanvasLayer

func type_dialog(text):
	%dialog_label.text = ""
	for charac in text:
		%dialog_label.text += charac
		await get_tree().create_timer(0.05).timeout
	return
		
func set_speaker(text):
	%speaker_label.text = text

func set_color(color):
	%dialog_label.self_modulate = Color(color)
