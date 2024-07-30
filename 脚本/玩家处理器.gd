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
	var card = character.抽牌堆.drawCard()
	character.手牌堆.cards.append(card)

func draw_cards(amount:int) -> void:
	if hand.get_children().size() >= 12:
		return
		
	
	for i in range(amount):
		draw_card()
	
	sort_card()
		#tween.tween_callback(draw_card)
		#tween.tween_interval(HAND_DRAW_INTERVAL)
	#
	#tween.finished.connect(player_hand_draw)


func player_hand_draw() ->void:
	events.playerHandDraw.emit()
	
func sort_card():
	var tween := create_tween()
	
	character.手牌堆.cards.sort_custom(sort)
	for i in range(character.手牌堆.cards.size()):
		var card = character.手牌堆.cards[i]
		tween.tween_callback(hand_add_card.bind(card))
		tween.tween_interval(HAND_DRAW_INTERVAL)
		
	tween.finished.connect(player_hand_draw)

func hand_add_card(card):
	hand.addCard(card)

func sort(a,b):
	return a.编号 < b.编号
	

