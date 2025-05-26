extends Area2D

## String: Message
@export var message := "Hello from the sign!"
## Choices are: fadeIn, fadeOut, both
@export var fade := "both" 

var player_in_area := false
var can_trigger := true

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _process(_delta):
	if player_in_area:
		if Input.is_action_just_pressed("ui_accept") and can_trigger:
			can_trigger = false
			await Talk.show_message(fade, message)
			can_trigger = true  # Re-enable trigger after message is done
