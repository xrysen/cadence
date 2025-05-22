extends Node

var dialogue_box := preload("res://Engine/Dialogue/DialogueBox.tscn").instantiate()

func _ready():
	call_deferred("_add_dialogue_box")

func _add_dialogue_box():
	get_tree().root.add_child(dialogue_box)
	dialogue_box.visible = false
