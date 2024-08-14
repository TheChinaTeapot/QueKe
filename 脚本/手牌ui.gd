extends CanvasLayer
class_name BattleUI

@export var character:Character :set = set_char
@export var 胡牌:胡牌检测

@onready var hand: Hand = $"Control/手牌"
@onready var manaui: ManaUI = $"Control/剩余出牌数"
@onready var button1: Button = $"Control/打出牌"
@onready var button2: Button = $"Control/重新选牌"
@onready var endbutton: Button = $"Control/回合结束"
@onready var __: VBoxContainer = $"Control/出牌区背景/出牌区/雀头"
@onready var 出牌区: VBoxContainer = $"Control/出牌区背景/出牌区/出牌区"

var count :int = 0
var num : int = 0
var PlayedCards : Array
var PlayedCard: CardUI 
var 即将打出的牌型:int = 0
var 要被替换的牌型:int = 0
var 牌型1:int = 0
var 牌型2:int = 0
var 牌型3:int = 0
var 牌型4:int = 0
var 胡牌2

func _ready() -> void:
	胡牌2 = 胡牌.duplicate()
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
	button1.disabled = !hand.cardsPlayed

func 判断牌型辅助方法(array):
	var 牌型
	if 胡牌2.杠子(array) or 胡牌2.顺子(array) or 胡牌2.刻子(array):
		牌型 = 3
	elif 胡牌2.对子(array):
		牌型 = 2
	else:
		牌型 = 1
	return 牌型

func 判断牌型():
	var cards = []
	for card in PlayedCards:
		cards.append(card.card)
	if 胡牌2.杠子(cards) or 胡牌2.顺子(cards) or 胡牌2.刻子(cards):
		即将打出的牌型 = 3
	elif 胡牌2.对子(cards):
		即将打出的牌型 = 2
	else:
		即将打出的牌型 = 1 
		
	var _1 = 出牌区.get_child(0).get_children()
	var array1 = []
	for i in _1:
		array1.append(i.card)
		
	var _2 = 出牌区.get_child(1).get_children()
	var array2 = []
	for i in _2:
		array2.append(i.card)
		
	var _3 = 出牌区.get_child(2).get_children()
	var array3 = []
	for i in _3:
		array3.append(i.card)
		
	var _4 = 出牌区.get_child(3).get_children()
	var array4 = []
	for i in _4:
		array4.append(i.card)
		
	var arrays = [array1, array2, array3, array4]
	var 牌型数组 = [0, 0, 0, 0]
	for i in range(4):
		牌型数组[i] = 判断牌型辅助方法(arrays[i])
		print(牌型数组[i])
	for i in range(4):
		if 即将打出的牌型 > 牌型数组[i]:
			
			要被替换的牌型 = i + 1 
			break  
		else:
			要被替换的牌型 = 0

func _on_打出牌_pressed() -> void:
	var damage2:int
	var damage:int
	var 雀头:Array = []
	for i in __.get_children():
		雀头.append(i.card)
	
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
	判断牌型()
	match 要被替换的牌型:
		1:
			var array1 = []
			for i in 出牌区.get_child(0).get_children():
				i.queue_free()
			for j in range(出牌区.get_child(0).get_children().size()):
				if 出牌区.get_child(0).get_children().size() == 0:
					return
				var card = 出牌区.get_child(0).get_children()[j]
				character.弃牌堆.cards.append(card.card)
			array1.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array1.append(card.card)
				出牌区.get_child(0).add_child(card.duplicate())
					
			damage2 = 胡牌2.计算伤害(array1)
		2:
			var array2 = []
			for i in 出牌区.get_child(1).get_children():
				i.queue_free()
			for j in range(出牌区.get_child(1).get_children().size()):
				if 出牌区.get_child(1).get_children().size() == 0:
					return
				var card = 出牌区.get_child(1).get_children()[j]
				character.弃牌堆.cards.append(card.card)
			array2.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array2.append(card.card)
				出牌区.get_child(1).add_child(card.duplicate())
					
			damage2 = 胡牌2.计算伤害(array2)
		3:
			var array3 = []
			for i in 出牌区.get_child(2).get_children():
				i.queue_free()
			for j in range(出牌区.get_child(2).get_children().size()):
				if 出牌区.get_child(2).get_children().size() == 0:
					return
				var card = 出牌区.get_child(2).get_children()[j]
				character.弃牌堆.cards.append(card.card)
			array3.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array3.append(card.card)
				出牌区.get_child(2).add_child(card.duplicate())
					
			damage2 = 胡牌2.计算伤害(array3)
		4:
			var array4 = []
			for i in 出牌区.get_child(3).get_children():
				i.queue_free()
			for j in range(出牌区.get_child(3).get_children().size()):
				if 出牌区.get_child(3).get_children().size() == 0:
					return
				var card = 出牌区.get_child(3).get_children()[j]
				character.弃牌堆.cards.append(card.card)
			array4.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array4.append(card.card)
				出牌区.get_child(3).add_child(card.duplicate())
					
			damage2 = 胡牌2.计算伤害(array4)
		0:
			var array1 = []
			var new: HBoxContainer
			if 出牌区.get_child(0).get_children().is_empty():
				new = 出牌区.get_child(0)
			elif 出牌区.get_child(1).get_children().is_empty():
				new = 出牌区.get_child(1)
			elif 出牌区.get_child(2).get_children().is_empty():
				new = 出牌区.get_child(2)
			elif 出牌区.get_child(3).get_children().is_empty():
				new = 出牌区.get_child(3)
			else:
				出牌区.get_child(0).queue_free()
				new = HBoxContainer.new()
				出牌区.add_child(new)
			
			for i in range(出牌区.get_child(0).get_children().size()):
				if 出牌区.get_child(0).get_children().size() == 0:
					return
				var card = 出牌区.get_child(0).get_children()[i]
				character.弃牌堆.cards.append(card.card)
			array1.clear()
					
			for i in range(PlayedCards.size()):
				var card = PlayedCards[i]
				array1.append(card.card)
				new.add_child(card.duplicate())
				
			damage2 = 胡牌2.计算伤害(array1)

	PlayedCards.clear()
	character.playerTurnEnd()

	var _1 = 出牌区.get_child(0).get_children()
	var _array1 = []
	for i in _1:
		_array1.append(i.card)

	var _2 = 出牌区.get_child(1).get_children()
	var _array2 = []
	for i in _2:
		_array2.append(i.card)

	var _3 = 出牌区.get_child(2).get_children()
	var _array3 = []
	for i in _3:
		_array3.append(i.card)

	var _4 = 出牌区.get_child(3).get_children()
	var _array4 = []
	for i in _4:
		_array4.append(i.card)
		
	damage = 胡牌2.是否胡牌(_array1,_array2,_array3,_array4,雀头)
	if global.chooseEnemy.size()>0:
		for i in range(global.chooseEnemy.size()):
			var enemy = global.chooseEnemy[i]
			if enemy == null:
				return
			enemy.takeDamage(damage2)
			enemy.takeDamage(damage)

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
