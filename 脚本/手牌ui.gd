extends CanvasLayer
class_name BattleUI

@export var character:Character :set = set_char

@onready var hand: Hand = $"手牌"
@onready var manaui: ManaUI = $"剩余出牌数"
@onready var button1: Button = $"打出牌"
@onready var endbutton: Button = $"回合结束"

var count :int = 0

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
		if count >= character.最大出牌数:
			child.playable = false
			button1.disabled = true

func _on_打出牌_pressed() -> void:
	for i in range(hand.get_children().size()):
		var card = hand.get_children()[i]
		if count < character.最大出牌数:
			if card.choose:
				
				card.play()
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
