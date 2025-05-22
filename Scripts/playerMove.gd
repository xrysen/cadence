extends CharacterBody2D

@export var speed := 100.0  # Adjust as needed

@onready var sprite := $AnimatedSprite2D
var last_direction := Vector2.DOWN  # default starting direction

func _ready() -> void:
	$Camera2D.make_current()

func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO
	
	if GameState.current_mode != GameState.GameMode.EXPLORE:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()
	velocity = input_vector * speed
	move_and_slide()
	
	update_animation(input_vector)
	
func update_animation(direction: Vector2) -> void:
	if direction != Vector2.ZERO:
		last_direction = direction
		sprite.animation = "walk_" + get_facing_direction(direction)
	else:
		sprite.animation = "idle_" + get_facing_direction(last_direction)
		
	sprite.play()
	
func get_facing_direction(direction: Vector2 = velocity.normalized()) -> String:
	if direction.x != 0:
		return "right" if direction.x > 0 else "left"
	elif direction.y != 0:
		return "down" if direction.y > 0 else "up"
	return "down"  # fallback
