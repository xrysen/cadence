extends CharacterBody2D

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var speed := 100.0  # Adjust as needed

@onready var sprite := $AnimatedSprite2D
var current_direction = Direction.DOWN  # Default facing down

@onready var camera := $Camera2D

func _ready():
	if GameState.spawn_position != Vector2.INF:
		global_position = GameState.spawn_position
		GameState.spawn_position = Vector2.INF  # Reset to avoid reuse
	current_direction = GameState.player_direction
	camera.make_current()
	camera.reset_smoothing()  # Snap to current position immediately
	update_animation()

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

	update_direction_from_vector(input_vector)
	update_animation()

func update_direction_from_vector(dir_vec: Vector2) -> void:
	if dir_vec == Vector2.ZERO:
		return  # No direction change

	# Prioritize horizontal direction for diagonals
	if dir_vec.x != 0:
		current_direction = Direction.RIGHT if dir_vec.x > 0 else Direction.LEFT
	else:
		# No horizontal input, use vertical direction
		if dir_vec.y != 0:
			current_direction = Direction.DOWN if dir_vec.y > 0 else Direction.UP
	
	GameState.player_direction = current_direction

func update_animation() -> void:
	if velocity.length() > 0:
		sprite.animation = get_walk_animation()
	else:
		sprite.animation = get_idle_animation()
	sprite.play()

func get_walk_animation() -> String:
	match current_direction:
		Direction.UP:
			return "walk_up"
		Direction.DOWN:
			return "walk_down"
		Direction.LEFT:
			return "walk_left"
		Direction.RIGHT:
			return "walk_right"
	return "walk_down"  # fallback

func get_idle_animation() -> String:
	match current_direction:
		Direction.UP:
			return "idle_up"
		Direction.DOWN:
			return "idle_down"
		Direction.LEFT:
			return "idle_left"
		Direction.RIGHT:
			return "idle_right"
	return "idle_down"  # fallback
