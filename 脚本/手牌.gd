extends HBoxContainer
class_name Hand

@export var char:Character

@onready var cardUI := preload("res://场景/卡牌.tscn")

var cardsPlayed := 0

func _ready():
	events.cardPlayed.connect(OnCardPlayed)
	

func OnCardUIReParent(child:CardUI):
	child.reparent(self)
	var newIndex = clampi(child.originalIndex - cardsPlayed,0,get_child_count())
	move_child.call_deferred(child,newIndex)

func OnCardPlayed():
	cardsPlayed += 1
	
