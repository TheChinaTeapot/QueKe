extends Node
class_name PlayerHandler

const HAND_DRAW_INTERVAL := 0.25

@export var hand:Hand

var character:Character

func _ready() -> void:
	events.cardPlayed.connect(play_card)

func start_battle(value:Character) -> void:
	character = value
	character.抽牌堆 = character.当前牌堆.duplicate(true)
	character.抽牌堆.shuffle()
	character.弃牌堆 = CardPile.new()

func start_trun() -> void:
	character.流动资金 = 0
	character.reset_mana()
	draw_cards(character.最大抽牌数)
	
func draw_card() -> void:
	reshuffle_deck_from_discard()
	var card = character.抽牌堆.drawCard()
	character.手牌堆.cards.append(card)
	reshuffle_deck_from_discard()

func draw_cards(amount:int) -> void:
	var num = clampi(amount - hand.get_children().size(),0,amount)
	for i in range(num):
		draw_card()
	
	sort_card()

func player_hand_draw() ->void:
	events.playerHandDraw.emit()

func play_card(card:Card):
	character.手牌堆.cards.erase(card)

func sort_card():
	var tween := create_tween()
	
	#character.手牌堆.cards.sort_custom(sort)
	
	for i in range(character.手牌堆.cards.size()):
		var card = character.手牌堆.cards[i]
		
		for o in hand.get_children():
			o.queue_free()
		tween.tween_callback(hand_add_card.bind(card,i))
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	tween.finished.connect(player_hand_draw)

func reshuffle_deck_from_discard() -> void:
	if not character.抽牌堆.empty():
		return
	
	while not character.弃牌堆.empty():
		character.抽牌堆.addCard(character.弃牌堆.drawCard())
	
	character.抽牌堆.shuffle()
	

func hand_add_card(card,i):
	
	hand.addCard(card)
	
	var children = hand.get_children()
	var child = children[i]
	child.card = card
	
#
#func sort(a,b):
	#return a.编号 < b.编号
	
func end_turn() -> void:
	var stateMachine = get_tree().get_first_node_in_group("state")
	stateMachine.send_event("回合结束")
