extends CanvasLayer

@onready var panel := $Panel
@onready var text_label := $Panel/TextLabel

@export var typing_speed := 0.03
signal dialogue_finished

var is_showing = false

func show_message(fade: String, text: String) -> void:
	if is_showing:
		await dialogue_finished  # Wait for previous message to finish

	is_showing = true
	GameState.current_mode = GameState.GameMode.DIALOGUE

	text_label.text = ""
	
	visible = true

	# Fade in the panel
	if fade == "fadeIn" or fade == "both":
		# Clear previous content and start transparent
		panel.modulate.a = 0.0
		var tween = get_tree().create_tween()
		tween.tween_property(panel, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await tween.finished

	# Typing effect
	await _type_text(text)

	# Wait for input
	await _wait_for_continue()

	# Optionally fade out
	if fade == "fadeOut" or fade == "both":
		var fade_out = get_tree().create_tween()
		fade_out.tween_property(panel, "modulate:a", 0.0, 0.2)
		await fade_out.finished

	visible = false
	is_showing = false
	GameState.current_mode = GameState.GameMode.EXPLORE
	emit_signal("dialogue_finished")


func _type_text(text: String) -> void:
	for char in text:
		text_label.text += char
		await get_tree().create_timer(typing_speed).timeout

func _wait_for_continue():
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("ui_accept"):
			break
