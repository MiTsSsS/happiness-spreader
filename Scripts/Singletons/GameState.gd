extends Node

var currentEmployeeInDialog:Employee

func setHasFinishedDialogWithEmployee(value):
	currentEmployeeInDialog.hasInteractedWith = true
	currentEmployeeInDialog.updateEmotionalState(value)
	
