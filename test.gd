extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await TextBox.show_message("fadeIn", "This is my textbox")
	await TextBox.show_message("none", "There shouldn't be any fade out all here")
	await TextBox.show_message("fadeOut", "This comes after")
	await TextBox.show_message("both", "This should fade in and out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
