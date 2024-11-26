extends CharacterBody2D

const SPEED = 300.0

@export var Sprite : AnimatedSprite2D

var frozen := false

var keyb = true

@export var InteractionColliderDistance := 50.0

func deadzone(x, dead_range):
	if x >= -dead_range and x <= dead_range:
		return 0
	return x

func _input(event: InputEvent) -> void:
	if (event is InputEventJoypadButton) or (event is InputEventJoypadMotion):
		keyb = false
	else:
		keyb = true

func _physics_process(delta: float) -> void:
	if frozen: return
	
	var xInputDir = deadzone(Input.get_joy_axis(0, JOY_AXIS_LEFT_X), 0.1)
	var yInputDir = deadzone(Input.get_joy_axis(0, JOY_AXIS_LEFT_Y), 0.1)
	
	if keyb:
		xInputDir = Input.get_axis("LEFT", "RIGHT")
		yInputDir = Input.get_axis("UP", "DOWN")

	
	var inputDir = Vector2(xInputDir, yInputDir)
	
	if inputDir != Vector2.ZERO:
		%CollisionShape2D.position = inputDir * InteractionColliderDistance
	
	if xInputDir != 0:
		if Sprite.frame == 0: Sprite.frame = 1
		Sprite.play("walk")
		if deadzone(xInputDir, 0.1) > 0:
			Sprite.flip_h = false
		elif deadzone(xInputDir, 0.1) < 0:
			Sprite.flip_h = true
	else:
		Sprite.stop()

	velocity = inputDir * SPEED

	move_and_slide()
