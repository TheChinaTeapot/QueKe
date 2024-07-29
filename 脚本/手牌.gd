extends HBoxContainer
class_name Hand

@export var char:Character

@onready var cardUI := preload("res://场景/卡牌.tscn")

var cardsPlayed := 0

func _ready():
	events.cardPlayed.connect(OnCardPlayed)
	

func addCard(card:Card) -> void:
	var new_card_ui := cardUI.instantiate()
	add_child(new_card_ui)
	new_card_ui.reParent.connect(OnCardUIReParent)
	new_card_ui.card = card
	new_card_ui.reparent(self)
	new_card_ui.chars = char

func OnCardUIReParent(child:CardUI):
	child.reparent(self)
	var newIndex = clampi(child.originalIndex - cardsPlayed,0,get_child_count())
	move_child.call_deferred(child,newIndex)

func OnCardPlayed():
	cardsPlayed += 1
	
