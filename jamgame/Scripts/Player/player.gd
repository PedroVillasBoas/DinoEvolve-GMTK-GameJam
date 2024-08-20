extends CharacterBody2D

class_name Player

const DINO_SPEED = 700.0
const JUMP_VELOCITY = -800.0

var can_move : bool = true
var is_chicken : bool = false
var is_dead : bool = false

@export var changer_handler : Changer_Handler

var dino_skin
var chicken_skin

signal dead
signal collectable

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	changer_handler.connect("chicken_time", Callable(self, "_on_chicken_time"))
	changer_handler.connect("dino_time", Callable(self, "_on_dino_time"))
	get_skins()
	chicken_skin.hide()
	dino_skin.show()

func _physics_process(delta: float) -> void:
	# Player is Jumping
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Player is not dead
	if can_move:
		if !is_chicken:
			handle_jump()
			handle_dino_movement(delta)
			move_and_slide()
		else:
			handle_chicken_movement(delta)
			move_and_slide()

# Input to make Player Jump
func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

# Input and Add Velocity to make Player Move || Make Player Stop moving if there's no Input
func handle_dino_movement(delta) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * DINO_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, DINO_SPEED)

# Input and Add Velocity to make Player Move || Make Player Stop moving if there's no Input
func handle_chicken_movement(delta) -> void:
	var direction := Input.get_axis("up", "down")
	if direction:
		velocity.y = direction * DINO_SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, DINO_SPEED)

func _on_chicken_time() -> void:
	set_motion_mode(MOTION_MODE_FLOATING)
	dino_skin.hide()
	chicken_skin.show()
	is_chicken = true

func _on_dino_time() -> void:
	set_motion_mode(MOTION_MODE_GROUNDED)
	dino_skin.show()
	chicken_skin.hide()
	is_chicken = false

func get_skins():
	for child in get_children():
		if child.is_in_group("Dino"):
			dino_skin = child
		else:
			chicken_skin = child

# Player Hit Something
func _on_dead() -> void:
	can_move = false
	is_dead = true
