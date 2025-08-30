extends Area2D
#var _gravity = 900
var velocity = Vector2()
var originalParent
var gravitySwitch = true
@export var prize = false

var toy_floor = 400

var toyWieght = 20
var originalX
var originalY
#Set this to true to stack toys on each other
var debug_gravity = false

var toyTypeList = ["Bird", "Cat", "Dog", "Frog", "Gorilla", "Monkey"]
var sizeTypeList = ["Small", "Medium", "Large"]
var colorTypeList = ["Blue", "Green", "Purple", "Red", "Yellow"]

var toyType = "Bird"
var toySize = "Large"
var toyColour = "Blue"

@onready var toy_sprite: Sprite2D = $ToySprite


func _ready() -> void:
	
	print(name)
	originalX = position.x
	originalY = position.y
	originalParent = self.get_parent()
	setToy(toyTypeList.pick_random(),sizeTypeList.pick_random(),colorTypeList.pick_random())
func _physics_process(delta: float) -> void:
	#if the toy is high up and not grabbed, it drops
	#if 	position.x < 375 and !self.get_parent().is_in_group("player"):
		#if gravitySwitch:
			#velocity.y += gravity * delta 
			#global_position.y += velocity.y * delta
	if global_position.y < toy_floor and !self.get_parent().is_in_group("player"):
		if gravitySwitch:
			velocity.y += gravity * delta 
			global_position.y += velocity.y * delta
	else:
		velocity.y = 0
func _on_body_entered(body: Node2D) -> void:
	#print("Body Entered")
	#print(body.name)
	gravitySwitch = true
	#if the claw touches it, it is grabbed
	if body.is_in_group("player") and !prize and position.y > 300:
		prize = true
		#Stores the global position it's in, otherwise, it will teleport 
			#and be messy
		var globalPos = global_position
		#the toy becomes a child of the claw, moving whenever it moves
		self.get_parent().remove_child(self)
		body.get_child(0).add_child(self)
		global_position = globalPos
func _on_crane_drop_toy(toy) -> void:
	if toy.prize:
		print("DropToy")
		#Take current global position
		var globalPos = toy.global_position
		#remove itself from parent
		toy.get_parent().remove_child(toy)
		#become child of original parent
		toy.originalParent.add_child(toy)
		#set to global position
		toy.global_position = globalPos
		#print(get_parent())
		toy.prize = false
func setToy(type, size, color):
	if randi_range(1,2) == 2:
		$ToySprite.flip_h = true
	else:
		$ToySprite.flip_h = false	
	toyType = type
	toySize = size
	toyColour = color
	match size:
		"Small":
			scale = Vector2(0.125,0.125)
			toyWieght = 10
		"Medium":
			scale = Vector2(0.25,0.25)
			toyWieght = 20
		"Large":
			scale = Vector2(0.375,0.375)
			toyWieght = 30
	match type:
		"Bird":
			match toyColour: 
				"Blue":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-bklue.png')
				"Green":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-green.png')
				"Purple":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-purple.png')
				"Red":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-red.png')
				"Yellow":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-bird/toy-bird-yellow.png')													
		"Cat":
			match toyColour: 
				"Blue":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-blue.png')
				"Green":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-green.png')
				"Purple":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-purple.png')
				"Red":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-red.png')
				"Yellow":
					toy_sprite.texture = load('res://Assets_Alvin/Sprites/Toy Sprites/toy-cat/toy-cat-yellow.png')
		"Dog":
			match toyColour: 
				"Blue":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-blue.png")
				"Green":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-green.png")
				"Purple":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-purple.png")
				"Red":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-red.png")
				"Yellow":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-dog/toy-dog-yellow.png")		
		"Frog":
			match toyColour: 
				"Blue":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-blue.png")
				"Green":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-green.png")
				"Purple":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-purple.png")
				"Red":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-red.png")
				"Yellow":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-frog/toy-frog-yellow.png")		
		"Gorilla":
			match toyColour: 
				"Blue":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-blue.png")
				"Green":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-green.png")
				"Purple":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-purple.png")
				"Red":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-red.png")	
				"Yellow":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-gorilla/toy-gorilla-yellow.png")	
		"Monkey":
			match toyColour: 
				"Blue":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-blue.png")
				"Green":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-green.png")
				"Purple":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-purple.png")
				"Red":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-red.png")
				"Yellow":
					toy_sprite.texture = load("res://Assets_Alvin/Sprites/Toy Sprites/toy-monkey/Toy-monkey-yellow.png")	

func resetPosition():
	position = Vector2(originalX, originalY)
	setToy(toyTypeList.pick_random(),sizeTypeList.pick_random(),colorTypeList.pick_random())	
func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("Detect") and debug_gravity:
		gravitySwitch = false
