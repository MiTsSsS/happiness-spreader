extends Node2D

class_name HappinessIndicator

@onready var emojiSprite:Sprite2D = $Emoji

#Preloading all emojis
@onready var HAPPY_NORMAL = preload("res://Art/Icons/Emojis/Happy_Normal.png")
@onready var CONFUSED = preload("res://Art/Icons/Emojis/Confused.png")
@onready var ANGRY_SAD_CRY = preload("res://Art/Icons/Emojis/Angry_Sad_Cry.png")
@onready var ANGRY = preload("res://Art/Icons/Emojis/Angry.png")
@onready var HAPPY_HEARTEYES_KISS = preload("res://Art/Icons/Emojis/Happy_HeartEyes_Kiss.png")

func updateEmoji(emojiKey):
	var textureToSet
	
	match emojiKey:
		0:
			textureToSet = HAPPY_NORMAL
		1:
			textureToSet = CONFUSED
		2:
			textureToSet = ANGRY
		3:
			textureToSet = ANGRY_SAD_CRY
		4:
			textureToSet = HAPPY_HEARTEYES_KISS
	
	emojiSprite.texture = textureToSet
