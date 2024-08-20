extends CharacterBody2D

class_name Player

const SPEED = 700.0
const JUMP_VELOCITY = -800.0

var can_move : bool = true
var is_chicken : bool = false
var is_dead : bool = false
var score : int = 0

signal dead
signal collectable

func _physics_process(delta: float) -> void:
	# Player is Jumping
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Player is not dead
	if can_move:
		handle_jump()
		handle_movement(delta)
		move_and_slide()

# Input to make Player Jump
func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

# Input and Add Velocity to make Player Move || Make Player Stop moving if there's no Input
func handle_movement(delta):
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

# Player Hit Something
func _on_dead() -> void:
	can_move = false
	is_dead = true
