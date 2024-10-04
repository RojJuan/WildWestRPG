extends CharacterBody2D

const SPEED = 300.0

@export var Sprite : AnimatedSprite2D
@export var InteractionCollider : CollisionShape2D

@export var InteractColliderDistance := 30.0

var frozen := false

func _physics_process(delta: float) -> void:
	if frozen: return
	
	var xInputDir = Input.get_axis("LEFT", "RIGHT")
	var yInputDir = Input.get_axis("UP", "DOWN")
	var inputDir = Vector2(xInputDir, yInputDir)
	
	velocity = inputDir
	velocity = velocity.normalized() * SPEED
	
	if !inputDir == Vector2.ZERO:
		InteractionCollider.position.x = InteractColliderDistance * xInputDir
		InteractionCollider.position.y = InteractColliderDistance * yInputDir
		Sprite.play("walk")
	else:
		Sprite.stop()
		
	if xInputDir > 0:
		Sprite.flip_h = false
	elif xInputDir < 0:
		Sprite.flip_h = true

	move_and_slide()
