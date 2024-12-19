extends Control



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$VBoxContainer/fullscreen.text = "Fullscreen: on"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		$VBoxContainer/fullscreen.text = "Fullscreen: off"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
