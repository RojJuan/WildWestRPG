extends Area2D

var is_in_hitbox := false
var is_in_converstation := false
var is_speaking := false

func on_entered(area : Area2D): 
	is_in_hitbox = true
	player = area.get_parent()
func on_exited(_area : Area2D): is_in_hitbox = false

@onready var dialog = $dialog

@export_enum("Activate on Interact", "Activate on Touch", "Activate Automatically") var InteractionType := 0 ## How the interaction is called
@export var Delete_After_Interact := false ## If the interaction body will be removed once the interaction finishes
@export_file("*.json") var Dialog ## The file of dialog to read from.
@export var Group := 0 ## The 'group' of lines to read from.

var CurrentLine := 0
var player = null

func _ready() -> void:
	if InteractionType == 2:
		do_dialog()

func _input(_event):
	if is_in_hitbox or InteractionType == 2:
		if Input.is_action_just_pressed("INTERACTION") and !is_speaking:
			await do_dialog()

func do_dialog():
	is_in_converstation = true
	
	var json_data = JSON.parse_string(FileAccess.get_file_as_string(Dialog))
	var clump = json_data[Group]
	
	if CurrentLine == len(clump):
		dialog.visible = false
		if player != null: player.frozen = false
		CurrentLine = 0
		if Delete_After_Interact == true: queue_free()
		return
	
	dialog.visible = true
	if player != null: player.frozen = true
	dialog.set_speaker(clump[CurrentLine].speaker)
	if clump[CurrentLine].keys().find("color") != -1:
		dialog.set_color(clump[CurrentLine].color)
	else:
		dialog.set_color("ffffff")
	is_speaking = true
	await dialog.type_dialog(clump[CurrentLine].text)
	is_speaking = false
	CurrentLine += 1
