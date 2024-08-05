extends Resource
class_name CardPile

signal SizeChanged(cardsAmount)

@export var cards:Array[Card] = []

func empty():
	return cards.is_empty()

func drawCard():
	var card = cards.pop_back()
	SizeChanged.emit(cards.size())
	return card

func head():
	var num = randi_range(1,49)
	while num % 10 == 0:
		num = randi_range(1,49)
	for card in cards:
		if card.编号 == num:
			cards.erase(card)
			cards.erase(card)
			return card

func addCard(card:Card):
	cards.append(card)
	SizeChanged.emit(cards.size())

func shuffle():
	cards.shuffle()

func clear():
	cards.clear()
	SizeChanged.emit(cards.size())

func _to_string():
	var _card_strings:PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%S: %s" % [i+1,cards[i].id])
		return "\n".join(_card_strings)
