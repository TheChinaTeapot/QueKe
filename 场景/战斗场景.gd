extends Node2D

@export var character:Character:set = set_character

@onready var playerhandler: PlayerHandler = $"玩家处理器"
@onready var battleui: BattleUI = $"手牌ui" as BattleUI
@onready var player: Player = $"玩家"

func _ready() -> void:
	events.playerTurnEnd.connect(playerhandler.end_turn)
	events.playerTurnStart.connect(playerhandler.start_trun)

func set_character(value:Character) -> void:
	await ready
	character = value
	battleui.character = value
	player.stats = value
	

func start_battle(_stats:Character) -> void:
	playerhandler.start_battle(character)

