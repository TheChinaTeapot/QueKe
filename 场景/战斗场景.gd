extends Node2D

@export var character:Character:set = set_character

@onready var playerhandler: PlayerHandler = $"玩家处理器"
@onready var battleui: BattleUI = $"手牌ui" as BattleUI

func set_character(value:Character) -> void:
	character = value
	battleui.char = character
	
	start_battle(character)

func start_battle(stats:Character) -> void:
	playerhandler.start_battle(character)
