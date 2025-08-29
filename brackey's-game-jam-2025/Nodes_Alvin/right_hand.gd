extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		texture = load("res://Assets_Alvin/Sprites/Right Hand/RH-Left.png")
	elif Input.is_action_pressed("right"):
		texture = load("res://Assets_Alvin/Sprites/Right Hand/RH-Right.png")
	else:
		texture = load("res://Assets_Alvin/Sprites/Right Hand/RH-default.png")
