extends Node2D
@onready var crane_machine_level: Node2D = $CraneMachineLevel
@onready var prize_corner: Node2D = $PrizeCorner
var tokens
signal tokenUse

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Screen test")
	crane_machine_level.visible = true
	crane_machine_level.set_process(true)
	prize_corner.visible = false
	prize_corner.set_process(false)
	reset_tokens()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_screen_change"):
		if crane_machine_level.visible:
			craneMachineOff()
			prizeCornerOn()
		else:
			craneMachineOn()
			prizeCornerOff()

func craneMachineOn():
	crane_machine_level.visible = true
	crane_machine_level.set_process(true)
func craneMachineOff():
	crane_machine_level.visible = false
	crane_machine_level.set_process(false)
func prizeCornerOn():
	prize_corner.visible = true
	prize_corner.set_process(true)
func prizeCornerOff():
	prize_corner.visible = false
	prize_corner.set_process(false)	
	
func reset_tokens():
	tokens = 10
	
