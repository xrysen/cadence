extends Node

enum GameMode {
	EXPLORE,
	BATTLE,
	MENU,
	DIALOGUE,
	CUTSCENE
}

var current_mode = GameMode.EXPLORE
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
