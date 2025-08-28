extends CharacterBody2D
@export var speed := 200
enum States {MOVE, GRAB, RETURN}
var state: States = States.MOVE
@export var stopHeight := 550
var craneTexture
signal dropToy(Node)
@export var openClaw = load('res://Assets_Alvin/Sprites/open_crane.png')
@export var closeClaw = load('res://Assets_Alvin/Sprites/closed_crane.png')
@onready var timer: Timer = $Timer
var netWeight = 0
var randomNum = 101

func _ready() -> void:
	position = Vector2(50,50)
func _process(delta: float) -> void:	
	if state == States.MOVE:
		move()
	elif state == States.GRAB:
		grab()
	elif state == States.RETURN:
		returnClaw()
	move_and_slide()
	
	#Used to test a toy dropping
	if Input.is_action_just_pressed("debug_drop"):
		print("dropped by debug")
		droptoy()
func move():
	#Player has control of the claw, moving it left or right
	#this usually allows the player to move in all cardinal directions
		#but for this, it's just utilizing left and right	
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2(1,0) or direction == Vector2 (-1,0)or direction == Vector2 (0,0) :
		velocity = direction * speed 
		
	#The player presses the button to lower the claw, atm this is Space Bar
	if Input.is_action_just_pressed("grab"):
		state = States.GRAB
func grab():
	#The claw lowers itself down from where the player left the claw
	if position.y < stopHeight and $"Toy Holder".get_child_count() == 0:
		velocity = Vector2(0,1) * speed
	else:
	#The claw stops then changes to the closed sprite then moves to the return state
		velocity = Vector2(0,0)
		craneTexture =load('res://Assets_Alvin/Sprites/closed_crane.png')
		$CraneSprite.texture = craneTexture
		state = States.RETURN
func returnClaw():

	#If the claw has any toys, their net weight is added 
		#together for the drop chance
	if $"Toy Holder".get_child_count() > 0 and randomNum == 101:
		randomNum = 102
		for n in $"Toy Holder".get_child_count():
			netWeight += get_node($"Toy Holder".get_child(n).get_path()).toyWieght
		print("start Timer")
		timer.start(1)
		timer.set_paused(false)

	#Random Drop Timer, based on some amount of time and weight, 
		#a random chance to drop. Ex: 40 Weight = 40% chance to drop
	if randomNum < netWeight:
		print("dropped at weight")
		droptoy()

	
	#The claw first moves back to the top, then back to the left side
		#The claw then returns to the open sprite
	if position.y > 50:
		velocity = Vector2(0,-1) * speed
	elif position.x > 50:
		velocity = Vector2(-1,0) * speed
	else:
		craneTexture = openClaw
		$CraneSprite.texture = craneTexture
		#The player resumes control of the claw
		print("Dropped at prize chute")
		droptoy()
		state = States.MOVE
func droptoy():
	#The claw drops the toy(s)
	timer.stop()
	for n in $"Toy Holder".get_child_count():
		#dropToy.emit($"Toy Holder".get_child(n))
		dropToy.emit($"Toy Holder".get_child(0))
	netWeight = 0
	randomNum = 101
		

func _on_timer_timeout() -> void:
	randomNum = randi_range(1, 100)
	print("One Second Passed")
	print(randomNum)
	pass # Replace with function body.
