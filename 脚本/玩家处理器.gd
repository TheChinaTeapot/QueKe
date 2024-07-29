extends Node
class_name PlayerHandler

const HAND_DRAW_INTERVAL := 0.25

@export var hand:Hand

var character:Character

func start_battle(value:Character) -> void:
	character = value
	character.抽牌堆 = character.当前牌堆.duplicate(true)
	character.抽牌堆.shuffle()
	character.弃牌堆 = CardPile.new()
	start_trun()

func start_trun() -> void:
	character.流动资金 = 0
	character.reset_mana()
	draw_cards(character.最大抽牌数)

func draw_card() -> void:
	hand.addCard(character.抽牌堆.drawCard())

func draw_cards(amount:int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(player_hand_draw)

func player_hand_draw() ->void:
	events.playerHandDraw.emit()
