extends Node2D

@export var character:Character:set = set_character
 
@onready var battleui: BattleUI = $"手牌ui" as BattleUI

func set_character(value:Character) -> void:
	character = value
	battleui.char = character
	
	start_battle(character)

func start_battle(stats:Character) -> void:
	print("战斗开始")
