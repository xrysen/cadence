extends CanvasLayer

@onready var panel := $ColorRect

signal fade_complete

func _ready():
	call_deferred("_init_fade")

func _init_fade():
	panel.color.a = 1.0  # Start fully opaque (black screen)
	panel.visible = true
	await get_tree().process_frame  # wait one frame to ensure node is ready
	await fadeIn()

func fadeOut(duration := 1.0):
	panel.visible = true  # Ensure it's visible before fading
	panel.color.a = 0.0   # Ensure it starts transparent
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "color:a", 1.0, duration)
	await tween.finished
	emit_signal("fade_complete")


func fadeIn(duration := 1.0) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(panel, "color:a", 0.0, duration)
	await tween.finished
	panel.visible = false
