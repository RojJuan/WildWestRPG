extends HSlider

@export var busName: String
 
var busIndex

func _ready() -> void:
	busIndex = AudioServer.get_bus_index(busName)
	
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))



func drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))
