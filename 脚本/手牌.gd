extends HBoxContainer
class_name Hand

@export var character:Character

@onready var cardUI := preload("res://场景/卡牌.tscn")

var cardsPlayed := false

func _physics_process(_delta: float) -> void:
	for i  in get_children():
		if i.choose:
			cardsPlayed = true
			break
		else:
			cardsPlayed = false


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
		var i1 = i
		var i2 = i + 1
		var i3 = i + 2
		var i4 = i + 3
		if i4 > children.size() - 1:
			i4 = i
		if i3 > children.size() - 1:
			i3 = i
		if i2 > children.size() - 1:
			i2 = i
		if i1 != i2 and i2 != i3 and i3 != i4:
			if children[i1].card == children[i2].card and children[i2].card == children[i3].card and children[i3].card == children[i4].card:
				character.set_max(4)
				break
		else:
			character.set_max(3)
 
func sort(a,b):
	return a.card.编号 < b.card.编号
