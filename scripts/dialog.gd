extends CanvasLayer

var speed = 0.05
var is_typing := false
func _input(_event) -> void:
	if Input.is_action_just_pressed("INTERACTION") and is_typing:
		speed = 0.008

func type_dialog(text):
	%dialog_label.text = ""
	is_typing = true
	for charac in text:
		%dialog_label.text += charac
		await get_tree().create_timer(speed).timeout
	is_typing = false
	speed = 0.05
	return

func set_speaker(text):
	%speaker_label.text = text

func set_color(color):
	%dialog_label.self_modulate = Color(color)
