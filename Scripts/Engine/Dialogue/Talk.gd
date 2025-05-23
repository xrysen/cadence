extends Node

var box: CanvasLayer

func _ready():
	var box_scene = preload("res://Scripts/Engine/Dialogue/DialogueBox.tscn")
	box = box_scene.instantiate()
	call_deferred("_add_box")

func _add_box():
	get_tree().root.add_child(box)
	box.visible = false

func show_message(fade: String, text: String) -> void:
	await box.show_message(fade, text)
