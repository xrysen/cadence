extends Node2D

func _ready():
	await get_tree().process_frame
	Fade.fadeIn(1.0)




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
