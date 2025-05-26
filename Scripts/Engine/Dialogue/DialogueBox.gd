extends CanvasLayer

@onready var panel := $Panel
@onready var text_label := $Panel/TextLabel

@export var typing_speed := 0.03
@export var fade := "both"
signal dialogue_finished

var is_showing = false

func show_message(fade: String, text: String) -> void:
	GameState.current_mode = GameState.GameMode.DIALOGUE
	if is_showing:
		await dialogue_finished

	is_showing = true
	visible = true
	text_label.text = ""
	panel.modulate.a = 0.0 if fade in ["fadeIn", "both"] else 1.0

	if fade in ["fadeIn", "both"]:
		var tween = get_tree().create_tween()
		tween.tween_property(panel, "modulate:a", 1.0, 0.3)
		await tween.finished

	await _type_text(text)
	await _wait_for_continue()

	if fade in ["fadeOut", "both"]:
		var tween_out = get_tree().create_tween()
		tween_out.tween_property(panel, "modulate:a", 0.0, 0.2)
		await tween_out.finished

	visible = false
	is_showing = false
	GameState.current_mode = GameState.GameMode.EXPLORE
	emit_signal("dialogue_finished")

func _type_text(text: String) -> void:
	for char in text:
		text_label.text += char
		await get_tree().create_timer(typing_speed).timeout

func _wait_for_continue() -> void:
	while true:
		await get_tree().process_frame
		if Input.is_action_just_pressed("ui_accept"):
			break
