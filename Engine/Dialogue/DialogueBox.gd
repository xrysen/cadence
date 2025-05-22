extends CanvasLayer

@onready var text_label: Label = $Panel/TextLabel

@export var typing_speed := 0.03  # seconds per character

var is_showing = false
signal dialogue_finished

func show_message(text: String) -> void:
	if is_showing:
		return  # Ignore if another message is still running

	GameState.current_mode = GameState.GameMode.DIALOGUE
	is_showing = true
	text_label.text = ""
	visible = true

	# Typing effect
	var typing = true
	var full_text = text
	var current_index = 0

	while typing:
		if current_index < full_text.length():
			text_label.text += full_text[current_index]
			current_index += 1
			await get_tree().create_timer(typing_speed).timeout
			if Input.is_action_just_pressed("ui_accept"):
				text_label.text = full_text
				break
		else:
			typing = false

	# Wait for user to press continue (e.g. Enter)
	await _wait_for_continue()
	GameState.current_mode = GameState.GameMode.EXPLORE
	visible = false
	is_showing = false
	emit_signal("dialogue_finished")

func _wait_for_continue():
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("ui_accept"):
			break
