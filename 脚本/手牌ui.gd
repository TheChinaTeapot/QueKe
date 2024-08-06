extends CanvasLayer
class_name BattleUI

@export var character:Character :set = set_char

@onready var hand: Hand = $"手牌"
@onready var manaui: ManaUI = $"剩余出牌数"
@onready var button1: Button = $"打出牌"
@onready var button2: Button = $"重新选牌"
@onready var endbutton: Button = $"回合结束"
@onready var _1: HBoxContainer = $"出牌区背景/出牌区/出牌区/出牌区1"
@onready var _2: HBoxContainer = $"出牌区背景/出牌区/出牌区/出牌区2"
@onready var _3: HBoxContainer = $"出牌区背景/出牌区/出牌区/出牌区3"
@onready var _4: HBoxContainer = $"出牌区背景/出牌区/出牌区/出牌区4"

var count :int = 0
var num : int = 0
var PlayedCards : Array
var PlayedCard: CardUI 
var array1:Array
var array2:Array
var array3:Array
var array4:Array

func _ready() -> void:
	events.playerHandDraw.connect(on_player_hand_draw)

func set_char(value:Character) -> void:
	character = value
	manaui.character_stats = character
	hand.character = character

func on_player_hand_draw():
	endbutton.disabled = false

func _physics_process(_delta: float) -> void:
	for child in hand.get_children():
		if count > character.最大出牌数:
			child.playable = false
			button1.disabled = true
	if character.出牌数 <= 0:
		button1.disabled = true
		button2.disabled = true
	else:
		button1.disabled = false
		button2.disabled = false
func _on_打出牌_pressed() -> void:
	for i in range(hand.get_children().size()):
		var card = hand.get_children()[i]
		if count <= character.最大出牌数:
			
			if card.choose:
				
				PlayedCard = card
				PlayedCard.disabled = true
				PlayedCard.played = true
				PlayedCards.append(PlayedCard)
				
				card.play()
				count = 0
	num += 1
	match num%4 :
		1:
			if _1.get_children().size() == 0:
				pass
			else:
				for child in _1.get_children():
					child.queue_free()
				for j in range(array1.size()):
					if array1.size() == 0:
						return
					var card = array1[j]
					character.弃牌堆.cards.append(card)
				array1.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array1.append(card.card)
				_1.add_child(card.duplicate())
				
		2:
			if _2.get_children().size() == 0:
				pass
			else:
				for child in _2.get_children():
					child.queue_free()
				for j in range(array2.size()):
					var card = array2[j]
					if card == null:
						break
					character.弃牌堆.cards.append(card)
				array2.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array2.append(card.card)
				_2.add_child(card.duplicate())
				
		3:
			if _3.get_children().size() == 0:
				pass
			else:
				for child in _3.get_children():
					child.queue_free()
				for j in range(array3.size()):
					var card = array3[j]
					if card == null:
						break
					character.弃牌堆.cards.append(card)
				array3.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array3.append(card.card)
				_3.add_child(card.duplicate())
				
		0:
			if _4.get_children().size() == 0:
				pass
			else:
				for child in _4.get_children():
					child.queue_free()
				for j in range(array4.size()):
					var card = array4[j]
					character.弃牌堆.cards.append(card)
				array4.clear()
				
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array4.append(card.card)
				_4.add_child(card.duplicate())
		_:
				pass
	PlayedCards.clear()
	character.playerTurnEnd()


func _on_重新选牌_pressed() -> void:
	count = 0
	button1.disabled = false
	for child in hand.get_children():
		child.playable = true
	var card_state_machines = get_tree().get_nodes_in_group("card_state")
	for card_state_machine in card_state_machines:
		card_state_machine.send_event("取消选择")


func _on_回合结束_pressed() -> void:
	endbutton.disabled = true
	events.playerTurnEnd.emit()
