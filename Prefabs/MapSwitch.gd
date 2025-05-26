extends Area2D

## MapScene to switch to
@export var target_scene_path: String
## Spawn Coords
@export var target_tile_position: Vector2 = Vector2.ZERO 

var player_inside = false

func _ready():
	connect("body_entered", _on_body_entered)
	
func _on_body_entered(body):
	if body.name == "Player" and not Fade.is_connected("fade_complete", Callable(self, "_on_fade_complete")):
		GameState.current_mode = GameState.GameMode.SCENE_CHANGE
		player_inside = true
		Fade.connect("fade_complete", Callable(self,"_on_fade_complete"))
		await Fade.fadeOut(1.0)

		

func _on_fade_complete():
	Fade.disconnect("fade_complete", Callable(self, "_on_fade_complete"))
	GameState.spawn_position = target_tile_position * 16
	GameState.current_mode = GameState.GameMode.EXPLORE
	get_tree().change_scene_to_file(target_scene_path)

