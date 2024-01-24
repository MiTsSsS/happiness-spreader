extends CharacterBody2D

class_name Employee

enum EmotionalState {
	ANGRY,
	ANGRY_SAD_CRY,
	CONFUSED,
	HAPPY_HEARTEYES_KISS,
	HAPPY_NORMAL,
}

enum EmployeeJob {
	DEVELOPER,
	DESIGNER,
	AUDIO,
	ARTIST,
	IT,
	ACCOUNTING,
}

#Node Init
@onready var interactPrompt = $InteractPrompt
@onready var debugNameLabel = $DebugName

#Happiness Properties Init
@onready var happinessIndicatorScript:HappinessIndicator = $HappinessIndicator
@onready var happinessLevel = 0
@onready var maxHappinessLevel = 10
@onready var emotionalState = EmotionalState.HAPPY_NORMAL
@onready var employeeJob = EmployeeJob.ACCOUNTING
@onready var employeeJobPool = [EmployeeJob.DEVELOPER, EmployeeJob.DESIGNER, EmployeeJob.AUDIO, EmployeeJob.ARTIST, EmployeeJob.IT, EmployeeJob.ACCOUNTING]
@onready var employeeHappinessLevelsPool = [10, 5, 6, 1, 8, 3]

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

func updateEmotionalState(level):
	pass
	
#Randomizes Employee's job and happiness level
func randomizeEmployeeStatus():
	var randomizedJob = employeeJobPool.pick_random()
	employeeJob = randomizedJob
	employeeJobPool.remove(randomizedJob)
	
	var randomHappinessLevel = employeeHappinessLevelsPool.pick_random()
	happinessLevel = randomHappinessLevel
	employeeHappinessLevelsPool.remove(randomHappinessLevel)
	
func resolveHappinessLevel():
	pass
