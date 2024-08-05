extends HBoxContainer
class_name Hand

@export var character:Character

@onready var cardUI := preload("res://场景/卡牌.tscn")

var cardsPlayed := 0

func addCard(card:Card) -> void:
	var new_card_ui := cardUI.instantiate()
	add_child(new_card_ui)
	new_card_ui.card = card
	new_card_ui.reparent(self)
	new_card_ui.characters = character

func sort_card():
	var children = get_children()
	children.sort_custom(sort)
	for i in range(children.size()):
		move_child(children[i], i)
func sort(a,b):
	return a.card.编号 < b.card.编号
