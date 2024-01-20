extends CharacterBody2D

class_name Employee

enum EmotionalState {
	ANGRY,
	ANGERY_SAD_CRY,
	CONFUSED,
	HAPPY_HEARTEYES_KISS,
	HAPPY_NORMAL,
}

#Node Init
@onready var interactPrompt = $InteractPrompt
@onready var debugNameLabel = $DebugName
@onready var happinessIndicator = $HappinessIndicator
@onready var happinessIndicatorScript:HappinessIndicator = $HappinessIndicator

#var Init
@onready var canInteract = false
@onready var emotionalState = EmotionalState.HAPPY_NORMAL

#Debug
@export var debugName:String

func _ready():
	happinessIndicatorScript.updateEmoji(0)
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
	happinessIndicatorScript.updateEmoji(1)
	print("PLAYER HAS INTERACTED WITH ")
	print(debugName)
