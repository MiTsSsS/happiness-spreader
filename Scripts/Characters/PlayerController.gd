extends CharacterBody2D

class_name Player

@onready var isInDialog = false

@export var speed = 550

var target = global_position
var employeesInRange = []

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
	if event.is_action_pressed("interact"):
		interactWithClosestEmployee()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	
	if position.distance_to(target) > 10:
		move_and_slide()

func interactWithClosestEmployee():
	if employeesInRange.size() == 0:
		return
	
	var closestEmployeeIndex = -1
	var distance = -1
	
	for employee in employeesInRange:
		var distanceWithCurrentEmployee = position.distance_to(employee.position)
		
		if distance == -1:
			distance = distanceWithCurrentEmployee
			closestEmployeeIndex = employeesInRange.find(employee)
		
		if distanceWithCurrentEmployee < distance:
			distance = distanceWithCurrentEmployee
			closestEmployeeIndex = employeesInRange.find(employee)
	
	var closestEmployee:Employee = employeesInRange[closestEmployeeIndex]
	closestEmployee.interactedWith()
	target = position
