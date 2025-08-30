extends Sprite2D

var level
var press
var default
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ring(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("grab"):
		texture = press
	else:
		texture = default
func ring(number):
	if number == 1:
		press = load("res://Assets_Alvin/Sprites/Left Hand/LH-pressed-ring.png")
		default = load("res://Assets_Alvin/Sprites/Left Hand/LH-default-ring.png")
	else:
		press = load("res://Assets_Alvin/Sprites/Left Hand/LH-pressed.png")
		default = load("res://Assets_Alvin/Sprites/Left Hand/LH-default.png")
