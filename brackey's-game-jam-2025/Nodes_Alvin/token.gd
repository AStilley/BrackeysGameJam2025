extends Sprite2D
@onready var crane: CharacterBody2D = $"../Crane"
var firstDig
var secondDig
var TokenString
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Tokens: ", crane.tokens)
	TokenString = str(crane.tokens)
	match TokenString[0]:
		"9":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/9.png")
		"8":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/8.png")
		"7":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/7.png")
		"6":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/6.png")
		"5":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/5.png")
		"4":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/4.png")
		"3":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/3.png")
		"2":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/2.png")
		"1":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/1.png")
		"0":
			firstDig = load("res://Assets_Alvin/Sprites/Numbers/0.png")	
	if(crane.tokens >= 10):	
		match TokenString[1]:
			"9":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/9.png")
			"8":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/8.png")
			"7":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/7.png")
			"6":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/6.png")
			"5":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/5.png")
			"4":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/4.png")
			"3":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/3.png")
			"2":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/2.png")
			"1":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/1.png")
			"0":
				secondDig = load("res://Assets_Alvin/Sprites/Numbers/0.png")	
	else:
		secondDig = null	
	$FirstDigit.texture = firstDig
	$SecondDigit.texture = secondDig
