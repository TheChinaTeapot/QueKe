extends CanvasLayer
class_name BattleUI

@export var character:Character :set = set_char

@onready var hand: Hand = $"手牌"
@onready var manaui: ManaUI = $"剩余出牌数"

func set_char(value:Character) -> void:
	character = value
	manaui.character_stats = character
	hand.character = character

