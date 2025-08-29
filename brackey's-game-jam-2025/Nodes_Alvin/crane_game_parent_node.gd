extends Node2D
@onready var crane_machine_level: Node2D = $CraneMachineLevel
@onready var main: Node2D = $Main


var tokens
signal tokenUse

var screen = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Screen test")
	crane_machine_level.visible = false
	crane_machine_level.set_process(false)
	main.visible = true
	main.set_process(true)
	reset_tokens()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_screen_change"):
		screen += 1
		print(screen)
		switchToScreen()
	
	
func switchToScreen():
	match screen:
		0:
			screen = 3
			switchToScreen()
		1:
			mainMenuOn()
			craneMachineOff()
			mainMenuOff()
			pass
		2:
			#Whatever the current level is
			craneMachineOn()
			mainMenuOff()
			pass
		3:
			screen = 1
			switchToScreen()
			mainMenuOn()
			pass
func craneMachineOn():
	crane_machine_level.visible = true
	crane_machine_level.set_process(true)
func craneMachineOff():
	crane_machine_level.visible = false
	crane_machine_level.set_process(false)
func mainMenuOn():
	main.visible = true
	main.set_process(true)
func mainMenuOff():
	main.visible = false
	main.set_process(false)
func reset_tokens():
	tokens = 10
	


func _on_start_pressed() -> void:
	screen+= 1
	switchToScreen()
	pass # Replace with function body.
