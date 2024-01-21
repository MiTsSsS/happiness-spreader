extends CharacterBody2D

class_name Employee

enum EmotionalState {
	ANGRY,
	ANGRY_SAD_CRY,
	CONFUSED,
	HAPPY_HEARTEYES_KISS,
	HAPPY_NORMAL,
}

#Node Init
@onready var interactPrompt = $InteractPrompt
@onready var debugNameLabel = $DebugName
@onready var happinessIndicatorScript:HappinessIndicator = $HappinessIndicator

#var Init
@onready var emotionalState = EmotionalState.HAPPY_NORMAL

#Debug
@export var debugName:String

func _ready():
	happinessIndicatorScript.updateEmoji(randi_range(0, 4))
	debugNameLabel.text = debugName

#On enter, show the E prompt and add to employees in range
func _on_interaction_area_body_entered(body):
	if body.is_in_group("player"):
		var player:Player = body
		player.employeesInRange.push_back(self)
		interactPrompt.visible = true

#On exit, remove the added stuff
func _on_interaction_area_body_exited(body):
	if body.is_in_group("player"):
		var player:Player = body
		player.employeesInRange.remove_at(player.employeesInRange.find(self))
		interactPrompt.visible = false
		
func interactedWith():
	happinessIndicatorScript.updateEmoji(randi_range(0, 4))
	print("PLAYER HAS INTERACTED WITH ")
	print(debugName)
