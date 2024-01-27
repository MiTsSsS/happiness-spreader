extends Node

enum EmployeeJob {
	DEVELOPER,
	DESIGNER,
	ARTIST,
	IT,
	HR,
}

@onready var employeeJobPool = [EmployeeStatusLoader.EmployeeJob.DEVELOPER, EmployeeStatusLoader.EmployeeJob.DESIGNER, EmployeeStatusLoader.EmployeeJob.ARTIST, EmployeeStatusLoader.EmployeeJob.IT, EmployeeStatusLoader.EmployeeJob.HR]
@onready var employeeHappinessLevelsPool = [10, 5, 6, 1, 8, 3, 5, 3, 5, 6, 1, 6, 3, 7, 9]
@onready var randomStorylines = ["firstStory", "secondStory", "thirdStory", "fourthStory"]
@onready var randomDialogStory = ["firstStory", "secondStory"]
