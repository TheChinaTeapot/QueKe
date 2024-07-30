extends Control
class_name CardUI

signal reParent(CardUI)

@onready var panel: Panel = $Panel
@onready var 图片: TextureRect = $"Panel/VBoxContainer/HBoxContainer/图片"
@onready var 名称: Label = $"Panel/VBoxContainer/HBoxContainer/名称"
@onready var 赋能效果: Label = $"Panel/VBoxContainer/赋能效果"
@onready var 污染效果: Label = $"Panel/VBoxContainer/污染效果"

const Theme1 = preload("res://资源/主题/主题1.tres")
const Theme2 = preload("res://资源/主题/主题2.tres")
const DRAG_MINMUM_THRESHOLD := 0.05

@export var card : Card : set = _set_card
@export var chars:Character : set = set_character

@onready var area_2d = $Area2D
@onready var originalIndex := self.get_index()
@onready var targets:Array[Node] = []
@onready var StateMachine: StateChart = $"状态机"

var playable := true : set = set_playable
var disabled := false
var minimumDragTimeElapsed := false
var played:bool
var mouseEnter:bool = false

func _ready():
	events.cardDragEnd.connect(OnCardDragEnd)
	events.cardDragStart.connect(OnCardDragStart)

func _set_card(value:Card):
	if not is_node_ready():
		await ready
	
	card = value
	图片.texture = card.图
	名称.text = card.点数
	
	if card.具体赋能 != null:
		赋能效果.visible = true
		名称.text = card.具体赋能.名称
		赋能效果.text = card.具体赋能.赋能效果
		
func set_playable(value:bool):
	playable = value
	if not playable:
		panel.modulate = Color8(200,200,200,255)
	else :
		panel.modulate = Color8(255,255,255,255)

func set_character(value:Character):
	chars = value
	chars.statsChanged.connect(on_character_stats_changed)

func OnCardDragEnd(_usedCard:CardUI):
	disabled = false
	self.playable = chars.can_play_card()
	
func OnCardDragStart(usedCard:CardUI):
	if usedCard == self:
		return
	
	disabled = true

func on_character_stats_changed():
	self.playable = chars.can_play_card()


func play():
	if not card:
		return
	if card.具体赋能!= null and card.具体赋能.目标 == card.具体赋能.目标对象.单一敌人:
		card.play(global.targets,chars)
	else:
		card.play(targets,chars)
	StateMachine.send_event("继续出牌")
	await $"状态机/玩家回合/卡牌默认".state_entered
	queue_free()

func _on_area_2d_area_entered(area):
	if not targets.has(area):
		targets.append(area)

func _on_area_2d_area_exited(area):
	targets.erase(area)

func _on_mouse_entered() -> void:
	if not playable or disabled:
		return
		
	self.theme = Theme2
	mouseEnter = true
	
	if card.污染增效 != null:
		污染效果.visible = true
		污染效果.global_position = get_global_mouse_position()
		污染效果.text = card.污染增效.污染效果

func _on_mouse_exited() -> void:
	if not playable or disabled:
		return
		
	self.theme = Theme1
	mouseEnter = false
	
	if card.污染增效 != null:
		污染效果.visible = false
		污染效果.global_position = global_position
		污染效果.text = ""

func _on_默认_state_entered() -> void:
	self.theme = Theme1
	reParent.emit(self)
	self.pivot_offset = Vector2.ZERO

func _on_默认_state_input(event: InputEvent) -> void:
	if not playable or disabled:
		return
	
	if event.is_action_pressed("left_mouse"):
		self.pivot_offset = Vector2(48,64)
		StateMachine.send_event("点击卡牌")

func _on_卡牌点击_state_entered() -> void:
	area_2d.monitoring = true
	events.clickcard.emit(self)

func _on_卡牌点击_state_input(event: InputEvent) -> void:
	if mouseEnter :
		if event is InputEventMouseMotion:
			StateMachine.send_event("拖动卡牌")

func _on_卡牌拖动_state_entered() -> void:
	var UI := get_tree().get_first_node_in_group("UI")
	if UI :
		self.reparent(UI)
	self.theme = Theme2
	events.cardDragStart.emit(self)
	
	minimumDragTimeElapsed = false
	var thresholdTimer := get_tree().create_timer(DRAG_MINMUM_THRESHOLD,false)
	thresholdTimer.timeout.connect(func(): minimumDragTimeElapsed = true)

func _on_卡牌拖动_state_exited() -> void:
	events.cardDragEnd.emit(self)

func _on_卡牌拖动_state_input(event: InputEvent) -> void:
	var MouseMotion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm  = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if MouseMotion :
		self.global_position = self.get_global_mouse_position() - pivot_offset
	
	if cancel:
		StateMachine.send_event("取消选择")
	elif confirm and minimumDragTimeElapsed:
		get_viewport().set_input_as_handled()
		StateMachine.send_event("打出卡牌")

func _on_卡牌打出_state_entered() -> void:
	played = false
	if not targets.is_empty():
		played = true
		play()

func _on_卡牌打出_state_input(_event: InputEvent) -> void:
	if played:
		return
	
	StateMachine.send_event("继续出牌")
