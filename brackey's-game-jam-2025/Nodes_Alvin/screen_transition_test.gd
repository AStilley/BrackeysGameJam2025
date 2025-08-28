extends Node2D
@onready var crane: Sprite2D = $Crane
@onready var prize_corner: Sprite2D = $PrizeCorner


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Screen test")
	crane.visible = true
	crane.set_process(true)
	prize_corner.visible = false
	prize_corner.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_screen_change"):
		print("Change screen")
		crane.visible = !crane.visible
		crane.set_process(crane.visible)
		prize_corner.visible = !prize_corner.visible
		prize_corner.set_process(prize_corner.visible)
