extends Stats
class_name Character
@export var 初始牌组: CardPile
@export var 最大抽牌数:int = 12
@export var 最大出牌数:int = 3

var 出牌数: int :set = set_mana
var 当前牌堆:CardPile 
var 弃牌堆:CardPile
var 抽牌堆:CardPile
var 手牌堆:CardPile
var 出牌堆:CardPile

func set_mana(value:int):
	出牌数 = value
	statsChanged.emit()
	
func set_max(value:int):
	self.最大出牌数 = value

func reset_mana():
	self.出牌数 = 1

func playerTurnEnd():
	self.出牌数 -= 1

func can_play_card():
	return 出牌数 > 0

func create_instance():
	var instance:Character = self.duplicate()
	instance.刀币 = 刀币
	instance.流动资金 = 0
	instance.reset_mana()
	instance.抽牌堆 = CardPile.new()
	instance.弃牌堆 = CardPile.new()
	instance.手牌堆 = CardPile.new()
	instance.出牌堆 = CardPile.new()
	instance.当前牌堆 = instance.初始牌组.duplicate()
	return instance
