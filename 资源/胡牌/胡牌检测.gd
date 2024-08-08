extends Resource
class_name 胡牌检测

@export var 胡牌:Array[胡牌条件]
var 番:Array = []
var damage:int

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
