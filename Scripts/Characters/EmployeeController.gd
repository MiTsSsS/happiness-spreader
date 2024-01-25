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

#Happiness Properties Init
@onready var happinessIndicatorScript:HappinessIndicator = $HappinessIndicator
@onready var happinessLevel = 0
@onready var maxHappinessLevel = 10
@onready var emotionalState = EmotionalState.HAPPY_NORMAL
@onready var employeeJob = EmployeeStatusLoader.EmployeeJob.ACCOUNTING

#Dialog
@export var dialog:DialogueResource
@export var dialogStart:String = "start"
@export var hasInteractedWith = false

#Debug
@export var debugName:String

func _ready():
	randomizeEmployeeStatus()
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
	if dialog != null:
		GameState.currentEmployeeInDialog = self
		DialogueManager.show_dialogue_balloon(dialog, dialogStart)		

func updateEmotionalState(level):
	happinessLevel += level
	happinessLevel = clampi(happinessLevel, 0, 10)
	resolveHappinessLevel()
	
#Randomizes Employee's job and happiness level
func randomizeEmployeeStatus():
	var randomizedJob = EmployeeStatusLoader.employeeJobPool.pick_random()
	employeeJob = randomizedJob
	EmployeeStatusLoader.employeeJobPool.remove_at(EmployeeStatusLoader.employeeJobPool.find(employeeJob))
	
	var randomHappinessLevel = EmployeeStatusLoader.employeeHappinessLevelsPool.pick_random()
	happinessLevel = randomHappinessLevel
	EmployeeStatusLoader.employeeHappinessLevelsPool.remove_at(EmployeeStatusLoader.employeeHappinessLevelsPool.find(happinessLevel))
	#$HappinessLevel.text =  happinessLevel.to_string()
	
	resolveHappinessLevel()
	
func resolveHappinessLevel():
	if happinessLevel >= 9:
		emotionalState = EmotionalState.HAPPY_HEARTEYES_KISS
		happinessIndicatorScript.updateEmoji(4)
	elif happinessLevel >= 7 and happinessLevel < 9:
		emotionalState = EmotionalState.HAPPY_HEARTEYES_KISS
		happinessIndicatorScript.updateEmoji(0)
	elif happinessLevel >= 5 and happinessLevel < 7:
		emotionalState = EmotionalState.CONFUSED
		happinessIndicatorScript.updateEmoji(1)
	elif happinessLevel >= 3 and happinessLevel < 5:
		emotionalState = EmotionalState.ANGRY
		happinessIndicatorScript.updateEmoji(2)
	elif happinessLevel >= 1 and happinessLevel < 3:
		emotionalState = EmotionalState.ANGRY_SAD_CRY
		happinessIndicatorScript.updateEmoji(3)
