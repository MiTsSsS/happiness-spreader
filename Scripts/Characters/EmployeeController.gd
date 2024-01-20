extends CharacterBody2D

class_name Employee

@onready var canInteract = false
@onready var interactPrompt = $InteractPrompt
@onready var debugNameLabel = $DebugName

@export var debugName:String

func _ready():
	debugNameLabel.text = debugName

#On enter, show the E prompt and add to employees in range
func _on_interaction_area_body_entered(body):
	if body.is_in_group("player"):
		var player:Player = body
		player.employeesInRange.push_back(self)
		canInteract = true
		interactPrompt.visible = true

#On exit, remove the added stuff
func _on_interaction_area_body_exited(body):
	if body.is_in_group("player"):
		var player:Player = body
		player.employeesInRange.remove_at(player.employeesInRange.find(self))
		canInteract = false
		interactPrompt.visible = false
		
func interactedWith():
	print("PLAYER HAS INTERACTED WITH ")
	print(debugName)
