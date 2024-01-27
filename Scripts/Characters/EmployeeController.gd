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

#Happiness Properties Init
@onready var happinessIndicatorScript:HappinessIndicator = $HappinessIndicator
@onready var happinessLevel = 0
@onready var maxHappinessLevel = 10
@onready var emotionalState = EmotionalState.HAPPY_NORMAL
@export var employeeJob = EmployeeStatusLoader.EmployeeJob.HR
@export var shouldReceiveDialog = false

#Dialog
@export var dialog:DialogueResource
@export var dialogStart:String = "start"
@export var hasInteractedWith = false
@onready var greetingDialog:String = "normal"

@onready var canInteract = true
@onready var RANDOMSTORYDIALOG = preload("res://Dialog/RandomStories.dialogue")
@onready var ARTDIALOG = preload("res://Dialog/Art_Dialog.dialogue")
@onready var DEVDIALOG = preload("res://Dialog/Dev_dialog.dialogue")
@onready var HRDIALOG = preload("res://Dialog/HR_Dialog.dialogue")
@onready var ITDIALOG = preload("res://Dialog/IT_Dialog.dialogue")
@onready var DESIGNDIALOG = preload("res://Dialog/Design_Dialog.dialogue")
@onready var commonDialog = preload("res://Dialog/CommonGreeting_Dialog.dialogue")

#Debug
@export var debugName:String

func _ready():
	if shouldReceiveDialog == false:
		disableAllEmployeeComponents()
		return
		
	randomizeEmployeeStatus()
	
	GameState.allEmps.push_back(self)
	
	match employeeJob:
		EmployeeStatusLoader.EmployeeJob.IT:
			GameState.itInScene.push_back(self)
		EmployeeStatusLoader.EmployeeJob.DEVELOPER:
			GameState.devInScene.push_back(self)
		EmployeeStatusLoader.EmployeeJob.DESIGNER:
			GameState.designInScene.push_back(self)
		EmployeeStatusLoader.EmployeeJob.ARTIST:
			GameState.artInScene.push_back(self)
		EmployeeStatusLoader.EmployeeJob.HR:
			GameState.hrInScene.push_back(self)
	
func setEmployeeJob(job):
	employeeJob = job

func disableAllEmployeeComponents():
		canInteract = false
		$HappinessIndicator.visible = false
		$InteractionArea.visible = false
		$InteractPrompt.visible = false
		$InteractionArea/InteractionRadius.disabled = true
		
func disableAllInteractableComponents():
		canInteract = false
		$InteractionArea.visible = false
		$InteractPrompt.visible = false
		$InteractionArea/InteractionRadius.disabled = true
		
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
	if dialog != null and canInteract == true:
		GameState.currentEmployeeInDialog = self
		DialogueManager.show_dialogue_balloon(commonDialog, greetingDialog)

func updateEmotionalState(level):
	happinessLevel += level
	happinessLevel = clampi(happinessLevel, 0, 10)
	resolveHappinessLevel()
	
#Randomizes Employee's job and happiness level
func randomizeEmployeeStatus():
	var isRandomStory = randi_range(0, 1)
	
	if isRandomStory == 1:
		dialog = RANDOMSTORYDIALOG
		var randomRandomStory = EmployeeStatusLoader.randomStorylines.pick_random()
		dialogStart = randomRandomStory
		EmployeeStatusLoader.randomStorylines.remove_at(EmployeeStatusLoader.randomStorylines.find(randomRandomStory))
	else:
		match employeeJob:
			EmployeeStatusLoader.EmployeeJob.IT:
				dialog = ITDIALOG
			EmployeeStatusLoader.EmployeeJob.DEVELOPER:
				dialog = DEVDIALOG
			EmployeeStatusLoader.EmployeeJob.DESIGNER:
				dialog = DESIGNDIALOG
			EmployeeStatusLoader.EmployeeJob.ARTIST:
				dialog = ARTDIALOG
			EmployeeStatusLoader.EmployeeJob.HR:
				dialog = HRDIALOG
		dialogStart = EmployeeStatusLoader.randomDialogStory.pick_random()
	
	var randomHappinessLevel = EmployeeStatusLoader.employeeHappinessLevelsPool.pick_random()
	happinessLevel = randomHappinessLevel
	EmployeeStatusLoader.employeeHappinessLevelsPool.remove_at(EmployeeStatusLoader.employeeHappinessLevelsPool.find(happinessLevel))
	
	resolveHappinessLevel()
	
func resolveHappinessLevel():
	if happinessLevel >= 9:
		emotionalState = EmotionalState.HAPPY_HEARTEYES_KISS
		happinessIndicatorScript.updateEmoji(4)
		greetingDialog = "happy"
	elif happinessLevel >= 7 and happinessLevel < 9:
		emotionalState = EmotionalState.HAPPY_HEARTEYES_KISS
		happinessIndicatorScript.updateEmoji(0)
		greetingDialog = "happy"
	elif happinessLevel >= 5 and happinessLevel < 7:
		emotionalState = EmotionalState.CONFUSED
		happinessIndicatorScript.updateEmoji(1)
		greetingDialog = "normal"
	elif happinessLevel >= 3 and happinessLevel < 5:
		emotionalState = EmotionalState.ANGRY
		happinessIndicatorScript.updateEmoji(2)
		greetingDialog = "sad"
	elif happinessLevel >= 1 and happinessLevel < 3:
		emotionalState = EmotionalState.ANGRY_SAD_CRY
		happinessIndicatorScript.updateEmoji(3)
		greetingDialog = "sad"
