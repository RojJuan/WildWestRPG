extends CharacterBody2D

const SPEED = 300.0

@export var Sprite : Sprite2D
@export var AnimPlayer : AnimationPlayer

var frozen := false

var xDir = "R"
var yDir = "U"
func _physics_process(delta: float) -> void:
	var xInputDir = Input.get_axis("LEFT", "RIGHT")
	var yInputDir = Input.get_axis("UP", "DOWN")
	
	velocity = Vector2(xInputDir, yInputDir) 
	velocity = velocity.normalized() * SPEED
	
	if xInputDir > 0:
		if xDir != "R":
			turned = false
		xDir = "R"
	elif xInputDir < 0:
		if xDir != "L":
			turned = false
		xDir = "L"
	
	change_direction()
	
	if frozen: velocity = Vector2.ZERO
	move_and_slide()

var turned = false
func change_direction():
	if !frozen:
		if xDir == "R" and !turned:
			AnimPlayer.play("flip_l")
			await AnimPlayer.animation_finished
			turned = true
		elif xDir == "L" and !turned:
			AnimPlayer.play("flip_r")
			await AnimPlayer.animation_finished
			turned = true
