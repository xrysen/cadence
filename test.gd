extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await TextBox.show_message("This is my textbox")
	await TextBox.show_message("This comes after")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
