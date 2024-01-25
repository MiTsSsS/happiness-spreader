extends Node

enum EmployeeJob {
	DEVELOPER,
	DESIGNER,
	AUDIO,
	ARTIST,
	IT,
	ACCOUNTING,
	HR,
}

@onready var employeeJobPool = [EmployeeStatusLoader.EmployeeJob.DEVELOPER, EmployeeStatusLoader.EmployeeJob.DESIGNER, EmployeeStatusLoader.EmployeeJob.AUDIO, EmployeeStatusLoader.EmployeeJob.ARTIST, EmployeeStatusLoader.EmployeeJob.IT, EmployeeStatusLoader.EmployeeJob.ACCOUNTING, EmployeeStatusLoader.EmployeeJob.HR]
@onready var employeeHappinessLevelsPool = [10, 5, 6, 1, 8, 3, 9]
