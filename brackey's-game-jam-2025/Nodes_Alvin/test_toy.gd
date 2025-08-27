extends Area2D
var _gravity = 900
var velocity = Vector2()
var originalParent
var gravitySwitch = true
@export var prize = false

var toyWieght = 20
#TO DO Add toyType, toySize, 

func _ready() -> void:
	originalParent = self.get_parent()
func _physics_process(delta: float) -> void:
	#if the toy is high up and not grabbed, it drops
	if global_position.y < 600 and !self.get_parent().is_in_group("player"):
		if gravitySwitch:
			velocity.y += gravity * delta 
			global_position.y += velocity.y * delta
	else:
		velocity.y = 0
func _on_body_entered(body: Node2D) -> void:
	print("Body Entered")
	print(body.name)
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


func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("Detect"):
		gravitySwitch = false # Replace with function body.
