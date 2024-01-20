extends Node2D

class_name HappinessIndicator

@onready var emojiSprite:Sprite2D = $Emoji

#Preloading all emojis
@onready var HAPPY_NORMAL = preload("res://Art/Icons/Emojis/Happy_Normal.png")
@onready var CONFUSED = preload("res://Art/Icons/Emojis/Confused.png")

func updateEmoji(emojiKey):
	var textureToSet
	
	match emojiKey:
		0:
			textureToSet = HAPPY_NORMAL
		1:
			textureToSet = CONFUSED
	
	emojiSprite.texture = textureToSet
