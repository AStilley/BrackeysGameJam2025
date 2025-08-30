extends CharacterBody2D
@export var speed := 200
enum States {MOVE, GRAB, RETURN}
var state: States = States.MOVE
@export var stopHeight := 450
var craneTexture 
signal dropToy(Node)
var idleClaw
var openClaw 
var closeClaw

var craneLeft = 150

signal gameOver

@onready var timer: Timer = $Timer
var netWeight = 0
var randomNum = 101
var craneType = ["Default","Gold", "Sticky"]
var currentCraneType
var tokenUse = true
var tokens 

var isGameOver = false

#Default is Default, Gold gives double the points, Sticky halves the weight
func _ready() -> void:
	position = Vector2(160,50)
	currentCraneType = craneType[0]
	print(currentCraneType)
	checkClawType()
	craneTexture = idleClaw
	reset_tokens()
func _process(_delta: float) -> void:	
	if state == States.MOVE:
		move()
	elif state == States.GRAB:
		grab()
	elif state == States.RETURN:
		returnClaw()
	move_and_slide()
	checkClawType()
	
	#debug tool
	if Input.is_action_pressed("debug_drop"):
		droptoy()
	#debug tool
	if Input.is_action_just_pressed("claw_cycle"):
		print("Change claw")
		match currentCraneType:
			"Default":
				currentCraneType = "Gold"
			"Gold":
				currentCraneType = "Sticky"
			"Sticky":
				currentCraneType = "Default"
func move():
	#Player has control of the claw, moving it left or right
	#this usually allows the player to move in all cardinal directions
		#but for this, it's just utilizing left and right	
	craneTexture = idleClaw
	if tokens >= 0:
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction == Vector2(1,0) or direction == Vector2 (-1,0)or direction == Vector2 (0,0) :
			if (direction == Vector2(-1,0) and position.x >= 160) or (direction == Vector2 (1,0) and position.x <= 850) or direction == Vector2 (0,0):
				velocity = direction * speed 
			else:
				velocity = Vector2(0,0)
			if tokenUse:
				tokens -= 1
				tokenUse = false
				print("Tokens: ", tokens)
		#The player presses the button to lower the claw, atm this is Space Bar
		if Input.is_action_pressed("grab"):
			state = States.GRAB
	else:#if you have no tokens left, gameover, but not if you got enough points
		#print("check for gameover")
		var toyNodes = get_tree().get_nodes_in_group("Toy")
		var toyBool = false
		for toy in toyNodes:
			if toy is Area2D:
				print(toy.position.x)
				if toy.position.x <= 265:
					toyBool = true
		if !toyBool:
			gameOver.emit()
func grab():
	#print("grab")
	#The claw lowers itself down from where the player left the claw
	craneTexture = openClaw
	if position.y < stopHeight and $"Toy Holder".get_child_count() == 0:
		velocity = Vector2(0,1) * speed
	else:
	#The claw stops then changes to the closed sprite then moves to the return state
		velocity = Vector2(0,0)
		craneTexture = closeClaw
		state = States.RETURN
func returnClaw():
	#print("return claw")
	#If the claw has any toys, their net weight is added 
		#together for the drop chance
	tokenUse = true
	if $"Toy Holder".get_child_count() > 0 and randomNum == 101:
		randomNum = 102
		for n in $"Toy Holder".get_child_count():
			netWeight += get_node($"Toy Holder".get_child(n).get_path()).toyWieght
		if currentCraneType == "Sticky":
			netWeight /= 2
		print("Netweight: ", netWeight)
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

	elif position.x > craneLeft:
		velocity = Vector2(-1,0) * speed
		
	else:
		craneTexture = idleClaw
		$CraneSprite.texture = craneTexture
		#The player resumes control of the claw
		droptoy()
		state = States.MOVE
func droptoy():
	#The claw drops the toy(s)
	timer.stop()
	for n in $"Toy Holder".get_child_count():
		dropToy.emit($"Toy Holder".get_child(0))
	netWeight = 0
	randomNum = 101
func _on_timer_timeout() -> void:
	randomNum = randi_range(1, 100)
	print("One Second Passed")
	print(randomNum)
	pass # Replace with function body.
func checkClawType():
	match currentCraneType:
		"Default":
			idleClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/Open.png")
			openClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/Open-wide.png")
			closeClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/Closed.png")
		"Gold":
			idleClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/Open-gold.png")
			openClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/open-wide-gold.png")
			closeClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/Closed-gold.png")
		"Sticky":
			idleClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/Open-red.png")
			openClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/open-wide-red.png")
			closeClaw = load("res://Assets_Alvin/Sprites/Crane Claw Sprites/Closed-red.png")
	#if $"Toy Holder".get_child_count() == 0:
	#	craneTexture = idleClaw
	#else:
	#	craneTexture = closeClaw
	$CraneSprite.texture = craneTexture
func reset_tokens():
	tokens = 10


func _on_gold_claw_button_down() -> void:
	if currentCraneType != "Gold" and tokens >= 3:
		currentCraneType = "Gold"
		tokens -= 3
		print("Tokens: ", tokens)
		#lose 3 tokens
func _on_red_claw_button_down() -> void:
	if currentCraneType != "Sticky" and tokens >= 3:
		currentCraneType = "Sticky"
		tokens -= 3
		print("Tokens: ", tokens)
		#lose 3 tokens
func craneReset():
	reset_tokens()
	currentCraneType = "Default"


func _on_toy_detect_check_tokens() -> void:
	if tokens < 0:
		gameOver.emit()
	pass # Replace with function body.
