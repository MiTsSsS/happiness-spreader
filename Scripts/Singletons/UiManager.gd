extends Node

class_name UiManager

@onready var progBar = $GridContainer/ProgressBar
@onready var textureEnd = $End/TextureRect
@onready var textEnd = $End/Label

@onready var GOOD = preload("res://Art/Ending/companyyay.png")
@onready var BAD = preload("res://Art/Ending/companynay.png")

@onready var goodEndText = "Wow, you're insane at your job, everyone is happy now and you got paid a lot, that's nuts."
@onready var badEndText = "Well, would you look at that, they're choking the CEO and burning down the office space, good stuff!"

func _ready():
	GameState.uiManager = self
	updateProgressBar(GameState.calculateHappinessPercentage())
	
func updateProgressBar(newVal):
	progBar.value = newVal
	
func showEndGame():
	if progBar.value < 25:
		textEnd.text = badEndText
		textureEnd.texture = BAD
	else:
		textEnd.text = goodEndText
		textureEnd.texture = GOOD
