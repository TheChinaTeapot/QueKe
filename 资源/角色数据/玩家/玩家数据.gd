extends Stats
class_name Character
@export var 初始牌组: CardPile = preload("res://资源/卡牌数据/牌堆/初始牌组.tres")
@export var 最大抽牌数:int = 12
@export var 最大出牌数:int = 4

var 出牌数: int :set = set_mana
var 当前牌堆:CardPile = 初始牌组.duplicate()
var 弃牌堆:CardPile
var 抽牌堆:CardPile
var 手牌堆:CardPile
var 出牌堆:CardPile

func set_mana(value:int):
	出牌数 = value
	statsChanged.emit()

func reset_mana():
	self.出牌数 = 3

func can_play_card():
	return 出牌数 > 0

func create_instance():
	var instance:Character = self.duplicate()
	instance.刀币 = 刀币
	instance.流动资金 = 0
	instance.reset_mana()
	#instance.当前牌堆 = 初始牌组.duplicate()
	instance.抽牌堆 = CardPile.new()
	instance.弃牌堆 = CardPile.new()
	instance.手牌堆 = CardPile.new()
	instance.出牌堆 = CardPile.new()
	return instance
