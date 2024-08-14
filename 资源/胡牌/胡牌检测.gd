extends Resource
class_name 胡牌检测

const HU = preload("res://资源/胡牌/胡牌条件/胡牌条件.tres")

@export var 胡牌:Array[胡牌条件]

var 番:Array = []
var damage:int
var damage2:int

func 是否胡牌(牌组1:Array,牌组2:Array,牌组3:Array,牌组4:Array,雀头:Array):
	for i in range(胡牌.size()):
		var 条件 = 胡牌[i].duplicate()
		var 结果 = 条件.具体条件(牌组1,牌组2,牌组3,牌组4,雀头)
		番.append(结果)
	
	for i in 番:
		if i == null:
			continue
		damage += i.damage
	
	return damage

func 计算伤害(当前牌组:Array):
	var 顺子吗 = 顺子(当前牌组)
	var 对子吗 = 对子(当前牌组)
	var 刻子吗 = 刻子(当前牌组)
	var 杠子吗 = 杠子(当前牌组)
	if 杠子吗:
		damage2 = 4
	elif 刻子吗:
		damage2 = 3
	elif 顺子吗:
		damage2 = 3
	elif 对子吗:
		damage2 = 2
	else:
		damage2 = 1
	return damage2

func 对子(当前牌组:Array):
	var 条件 = HU.duplicate()
	return 条件.对子(当前牌组)

func 顺子(当前牌组:Array):
	var 条件 = HU.duplicate()
	return 条件.顺子(当前牌组)

func 刻子(当前牌组:Array):
	var 条件 = HU.duplicate()
	return 条件.刻子(当前牌组)

func 杠子(当前牌组:Array):
	var 条件 = HU.duplicate()
	return 条件.杠子(当前牌组)
