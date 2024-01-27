extends Node

enum CurrentGameState {
	START,
	END,
}

var currentEmployeeInDialog:Employee
var uiManager:UiManager

@onready var allEmps = []
@onready var itInScene = []
@onready var devInScene = []
@onready var artInScene = []
@onready var designInScene = []
@onready var hrInScene = []

func setHasFinishedDialogWithEmployee(value):
	currentEmployeeInDialog.hasInteractedWith = true
	currentEmployeeInDialog.updateEmotionalState(value)
	currentEmployeeInDialog.disableAllInteractableComponents()
	uiManager.updateProgressBar(calculateHappinessPercentage())
	
func endedGreetingDialog():
	DialogueManager.show_dialogue_balloon(currentEmployeeInDialog.dialog, currentEmployeeInDialog.dialogStart)
	
func calculateHappinessPercentage() -> int:
	var totalHappiness:int = 0
	var totalInteractedWith = 0
	
	for employee:Employee in allEmps:
		if employee.shouldReceiveDialog == true:
			totalHappiness += employee.happinessLevel
			if employee.hasInteractedWith == true:
				totalInteractedWith += 1
	
	if totalInteractedWith == allEmps.size():
		endGame()
	
	return totalHappiness
	
func endGame():
	uiManager.showEndGame()

