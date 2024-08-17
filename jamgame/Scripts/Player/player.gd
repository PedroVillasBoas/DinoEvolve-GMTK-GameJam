extends CharacterBody2D

const SPEED = 700.0
const JUMP_VELOCITY = -800.0

@onready var animated_sprite: AnimatedSprite2D = $LokiFemale/AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if animated_sprite:
			animated_sprite.play("jump")

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			animated_sprite.play("movement")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and animated_sprite:
			animated_sprite.stop()

	if not is_on_floor() and animated_sprite and animated_sprite.animation != "jump":
		animated_sprite.play("jump")

	move_and_slide()
